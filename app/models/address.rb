# frozen_string_literal: true

class Address < ApplicationRecord
  validates :city, presence: true
  validates :street_number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :contact
end
