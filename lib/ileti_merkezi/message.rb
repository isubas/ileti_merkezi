# frozen_string_literal: true

module IletiMerkezi
  # Message
  class Message
    attr_reader :phones, :text

    def initialize(phones, text)
      @phones = Array(phones)
      @text   = text.to_s
    end

    def to_hash
      raise InvalidMessageError, inspect unless valid?

      {
        text: text,
        receipents: { number: phones }
      }
    end

    alias to_h to_hash

    def valid?
      phones.any? && !text.empty?
    end
  end
end
