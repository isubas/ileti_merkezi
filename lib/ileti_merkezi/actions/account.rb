# frozen_string_literal: true

module IletiMerkezi
  # Account
  class Account
    PATH =
      'http://dev.iletimerkezi.com/index.php?function=api&'\
      '&special_username=Ns_eemsm&special_password=_Arg_ns_mmm'

    class << self
      include XmlBuilder

      def info
        request(
          '&obj1=getUserInfo',
          hash_to_xml(userInfo: user_info)
        )
      end

      def senders
        request(
          '&obj1=getSmsHeader',
          hash_to_xml(smsApi: { userInfo: user_info.merge(smsType: 2) })
        )
      end

      private

      def user_info
        config = IletiMerkezi.configuration
        {
          userName: config.username,
          userPassword: config.password
        }
      end

      def request(query, body)
        request     = Request.new(body: body)
        request.uri = URI.parse(PATH + query)
        request.call
      end
    end
  end
end
