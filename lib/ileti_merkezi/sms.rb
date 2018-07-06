# frozen_string_literal: true

module IletiMerkezi
  # Sms
  class Sms
    attr_reader :args, :sender

    PATH = '/send-sms'.freeze

    def initialize(args)
      @args   = args
      @sender = args[:sender] || IletiMerkezi.configuration.sender
    end

    def messages
      messages = args.fetch(:messages, [args])
      messages.map { |msg| Message.new(msg[:phones], msg[:text]) }
    end

    def send_datetime
      args.fetch(:send_datetime, Time.now.strftime('%d/%m/%Y %H:%M'))
    end

    def send
      request = Request.new(content: content, path: PATH)
      request.call
    end

    private

    def content
      <<-XML.gsub(/^[ ]+/, '').strip
      <sender>#{sender}</sender>
      <sendDateTime>#{send_datetime}</sendDateTime>
      #{messages.map(&:content).join}
      XML
    end
  end
end
