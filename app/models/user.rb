# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  include User::Reportable

  after_create :enable_all_notifications

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_recover_password_instructions

  belongs_to :user_type, class_name: 'UserType', optional: true
  alias type user_type

  has_many :debates, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_one :profile_photo, class_name: 'Image', dependent: :destroy
  has_many :documents, class_name: 'Document', dependent: :destroy

  validates :dni,
            presence: { message: I18n.t(:dni_field_is_required) },
            format: { with: /\d[0-9]{6,7}/, message: I18n.t(:dni_invalid) },
            length: { maximum: 8, message: I18n.t(:dni_too_many_long) },
            uniqueness: { message: I18n.t(:dni_already_exists) }
  validates :email, presence: { message: I18n.t(:email_field_is_required) },
                    uniqueness: { message: I18n.t(:email_already_exists) }
  validates :phone, numericality: { only_integer: true, message: I18n.t(:should_be_only_integer) }, allow_blank: true
  validates :first_name, :last_name,
            format: { with: /\A[\p{L}\p{M}]{2,20}[" ]?[\p{L}\p{M}]?{2,20}[" ]?[\p{L}\p{M}]?{2,20}\z/,
                      message: I18n.t(:first_name_or_last_name_invalid) }

  delegate :name, to: :type, prefix: true, allow_nil: true
  delegate :url, to: :profile_photo, prefix: true, allow_nil: true

  scope :admin,         -> { includes(:user_type).where(user_types: { name: 'admin' }) }
  scope :administrator, -> { includes(:user_type).where(user_types: { name: 'administrador' }) }
  scope :driver,        -> { includes(:user_type).where(user_types: { name: 'conductor' }) }
  scope :mechanic,      -> { includes(:user_type).where(user_types: { name: 'mecanico' }) }
  scope :user,          -> { includes(:user_type).where(user_types: { name: 'usuario' }) }

  def photo
    {
      id: profile_photo.try(:id),
      url: profile_photo_url
    }
  end

  def role?(role)
    type_name == role
  end

  def get_doorkeeper_token
    Doorkeeper::AccessToken.active_for(self).last ||
      Doorkeeper::AccessToken.create(resource_owner_id: id,
                                     use_refresh_token: true,
                                     expires_in: Doorkeeper.configuration.access_token_expires_in.to_i)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def enable_all_notifications
    NotificationType.pluck(:id).each do |notification_type_id|
      enable = EnableNotificationType.find_by(user_id: id, notification_type_id: notification_type_id)

      if enable
        enable.update(enable: true)
      else
        EnableNotificationType.create(user_id: id, notification_type_id: notification_type_id, enable: true)
      end
    end
  end

  def send_recover_password_instructions
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)

    UserMailer.confirmation_instructions(self, raw).deliver_now
  end
end
