# frozen_string_literal: true

module IletiMerkezi
  # Account
  class Account
    PATH =
      'http://dev.iletimerkezi.com/index.php?function=api&'\
      '&special_username=Ns_eemsm&special_password=_Arg_ns_mmm'.freeze

    class << self
      def info
        request     = Request.new(body: body_for_info)
        request.uri = URI.parse(PATH + '&obj1=getUserInfo')
        request.call
      end

      def senders
        request     = Request.new(body: body_for_senders)
        request.uri = URI.parse(PATH + '&obj1=getSmsHeader')
        request.call
      end

      private

      def body_for_senders
        config = IletiMerkezi.configuration
        <<-XML.gsub(/^[ ]+/, '').strip
        <smsApi>
          <userInfo>
            <userName>#{config.username}</userName>
            <userPassword>#{config.password}</userPassword>
            <smsType>2</smsType>
          </userInfo>
        </smsApi>
        XML
      end

      def body_for_info
        config = IletiMerkezi.configuration
        <<-XML.gsub(/^[ ]+/, '').strip
        <userInfo>
          <userName>#{config.username}</userName>
          <userPassword>#{config.password}</userPassword>
        </userInfo>
        XML
      end
    end
  end
end
