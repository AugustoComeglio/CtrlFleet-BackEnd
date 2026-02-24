# frozen_string_literal: true

class Document < ApplicationRecord
  acts_as_paranoid

  after_create :add_initial_state
  after_save :check_expires_in
  after_save :send_notification, if: :expired?

  belongs_to :manager, class_name: 'User'
  belongs_to :user, class_name: 'User', optional: true
  belongs_to :vehicle, class_name: 'Vehicle', optional: true
  belongs_to :failure, class_name: 'Failure', optional: true

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :license_plate, to: :vehicle, prefix: true, allow_nil: true
  delegate :name, to: :failure, prefix: true, allow_nil: true

  has_many :document_states, class_name: 'DocumentState', dependent: :destroy
  has_many :state_documents, through: :document_states, class_name: 'StateDocument', source: :state_document

  def state
    state_documents.joins(:document_states).order('document_states.created_at').last.name
  end

  def change_state!(new_state)
    return true if new_state == state

    DocumentState.create(document_id: id, state_document_id: StateDocument.find_by(name: new_state).try(:id))
  end

  def expired?
    state == 'expirado'
  end

  private

  def add_initial_state
    DocumentState.create(document_id: id, state_document_id: StateDocument.find_by(name: 'vigente').id)
  end

  def check_expires_in
    return unless expires_in < Time.zone.now

    change_state!('expirado')
  end

  def send_notification
    return unless state == 'expirado' && expired?

    NotificationService.new((user || manager),
                            "Tu documento #{title} ha expirado",
                            "Tu documento #{title} alcanzo la fecha de expiración (#{expires_in.strftime("%d/%M/%Y")}). Por favor ingrese al sitio para actualizar tu documentacion #{title} a uno vigente",
                            id, self.class.to_s).exec
  end
end
