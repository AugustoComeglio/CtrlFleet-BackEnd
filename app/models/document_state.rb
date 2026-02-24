# frozen_string_literal: true

class DocumentState < ApplicationRecord
  belongs_to :document, class_name: 'Document'
  belongs_to :state_document, class_name: 'StateDocument'
end
