# frozen_string_literal: true

class GenerateContacts
  DEFAULT_DOMAIN_PART = '@example.com'

  def initialize(amount = 10_000)
    @amount = amount
  end

  def call
    prefix = SecureRandom.alphanumeric(8)

    results = []
    idx = 0

    while idx < amount
      results << {
        name: "#{prefix}_#{idx}",
        email: "#{prefix}_#{idx}".downcase + DEFAULT_DOMAIN_PART
      }
      idx += 1
    end

    results
  end

  private

  attr_reader :amount
end
