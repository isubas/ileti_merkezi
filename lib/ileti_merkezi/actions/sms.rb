# frozen_string_literal: true

module IletiMerkezi
  # Sms
  class Sms
    include XmlBuilder

    attr_reader :messages, :sender, :send_datetime

    PATH = '/send-sms'

    def initialize(params = {})
      @messages      = build_messages(params)
      @send_datetime = params.fetch(:send_datetime, Time.now.strftime('%d/%m/%Y %H:%M'))
      @sender        = params.fetch(:sender, IletiMerkezi.configuration.sender)
    end

    def send
      request = Request.new(
        path: PATH,
        payload: hash_to_xml(
          sender: sender,
          sendDateTime: send_datetime,
          message: messages.map(&:to_h)
        )
      )
      request.call
    end

    private

    def build_messages(params)
      messages = params.fetch(
        :messages,
        [
          phones: params.fetch(:phones, []),
          text: params.fetch(:text, '')
        ]
      )
      messages.map { |message| Message.new(*message.values_at(:phones, :text)) }
    end
  end
end
