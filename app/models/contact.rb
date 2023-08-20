# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :addresses, dependent: :delete_all

   accepts_nested_attributes_for :addresses
end
