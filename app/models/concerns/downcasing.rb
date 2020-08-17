# frozen_string_literal: true

module Downcasing
  extend ActiveSupport::Concern

  included do
    before_save :downcase_fields

    def downcase_fields
      self.class.searchable_attributes.each do |attr|
        send(attr).downcase! if send(attr).respond_to?(:downcase!)
      end
    end
  end
end
