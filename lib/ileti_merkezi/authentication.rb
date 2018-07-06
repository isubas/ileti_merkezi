# frozen_string_literal: true

module IletiMerkezi
  # Authentication
  module Authentication
    module_function

    def content
      send(IletiMerkezi.configuration.auth_method)
    end

    def auth_basic
      config = IletiMerkezi.configuration
      <<-XML.gsub(/^[ ]+/, '').strip
      <authentication>
        <username>#{config.username}</username>
        <password>#{config.password}</password>
      </authentication>
      XML
    end

    def auth_token
      config = IletiMerkezi.configuration
      <<-XML.gsub(/^[ ]+/, '').strip
      <authentication>
        <key>#{config.public_key}</key>
        <hash>#{config.hmac}</hash>
      </authentication>
      XML
    end
  end
end
