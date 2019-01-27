# frozen_string_literal: true

module IletiMerkezi
  # Authentication
  module Authentication
    include XmlBuilder

    module_function

    def to_hash
      send(IletiMerkezi.configuration.auth_method)
    end

    def auth_basic
      config = IletiMerkezi.configuration
      {
        username: config.username,
        password: config.password
      }
    end

    def auth_token
      config = IletiMerkezi.configuration
      {
        key: config.public_key,
        hash: config.hmac
      }
    end
  end
end
