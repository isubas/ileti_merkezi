# frozen_string_literal: true

module IletiMerkezi
  # Message
  class Message
    attr_reader :phones, :text

    def initialize(phones, text)
      @phones = phones.is_a?(Array) ? phones : [phones]
      @text   = text.to_s
    end

    def content
      raise InvalidMessageError, to_s unless valid?
      <<-XML.gsub(/^[ ]+/, '').strip
      <message>
        <text>#{text}</text>
        <receipents>
          #{phones.compact.map { |phone| phone_xmlify(phone) }.join("\n")}
        </receipents>
      </message>
      XML
    end

    def summary
      {
        text: text,
        phones: phones,
        receipents_count: phones.count,
        valid: valid?
      }
    end

    def to_s
      "Text: #{text}, Phones: #{phones}"
    end

    def valid?
      phones.any? && !text.empty?
    end

    private

    def phone_xmlify(phone)
      "<number>#{phone.to_s.tr(' ', '')}</number>" unless phone.to_s.empty?
    end
  end
end
