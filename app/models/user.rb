# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_type, class_name: 'UserType'
  alias type user_type

  has_many :debates, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_one :profile_photo, class_name: 'Image', dependent: :destroy

  validates :dni,
            presence: true,
            format: { with: /\d[0-9]{6,7}/, message: 'DNI invalido' },
            length: { maximum: 8 },
            uniqueness: { message: 'DNI ya registrado' }
  validates :email, presence: true, uniqueness: { message: 'Correo electronico ya registrado' }
  validates :phone, numericality: { only_integer: true }, allow_blank: true
  validates :first_name, :last_name,
            format: { with: /\A[\p{L}\p{M}]{2,20}[" ]?[\p{L}\p{M}]?{2,20}[" ]?[\p{L}\p{M}]?{2,20}\z/,
                      message: 'Nombres o Apellidos invalidos' }

  delegate :name, to: :type, prefix: true

  def role?(role)
    type_name == role
  end

  def get_doorkeeper_token
    Doorkeeper::AccessToken.active_for(self).last ||
      Doorkeeper::AccessToken.create(resource_owner_id: id,
                                     use_refresh_token: true,
                                     expires_in: Doorkeeper.configuration.access_token_expires_in.to_i)
  end
end
