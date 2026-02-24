# frozen_string_literal: true

class StateDocument < ApplicationRecord
  acts_as_paranoid

  has_many :document_states, class_name: 'DocumentState', dependent: :destroy
  has_many :documents, through: :document_states, class_name: 'Document', source: :state_document

  validates :name, presence: { message: I18n.t(:name_field_is_required) },
                   uniqueness: { message: I18n.t(:already_exists_object_with_name, class: 'Estado de Documento') }
end
