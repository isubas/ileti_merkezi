# frozen_string_literal: true

require 'openssl'

module IletiMerkezi
  # Configuration
  # :reek:TooManyInstanceVariables { max_instance_variables: 8 }
  class Configuration < Module
    # :reek:Attribute
    attr_accessor :endpoint,
                  :username,
                  :password,
                  :sender,
                  :public_key,
                  :secret_key,
                  :request_overrides

    ENDPOINT = 'http://api.iletimerkezi.com/v1'.freeze
    SENDER   = 'ILETI MRKZI'.freeze

    def initialize
      @endpoint          = ENV['IM_ENDPOINT'] || ENDPOINT
      @username          = ENV['IM_USERNAME']
      @password          = ENV['IM_PASSWORD']
      @public_key        = ENV['IM_PUBLIC_KEY']
      @secret_key        = ENV['IM_SECRET_KEY']
      @sender            = ENV['IM_SENDER'] || SENDER
      @request_overrides = {}
    end

    def auth_method
      if public_key && secret_key
        :auth_token
      elsif username && password
        :auth_basic
      else
        raise CredentialMissingError, 'Credentials missing'
      end
    end

    def hmac
      OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('sha256'), secret_key.to_s, public_key.to_s
      )
    end

    # set default config
    def default_config
      self.username   = ENV['IM_USERNAME']
      self.password   = ENV['IM_PASSWORD']
      self.public_key = ENV['IM_PUBLIC_KEY']
      self.secret_key = ENV['IM_SECRET_KEY']
      true
    end

    # config resets
    def reset
      self.username   = nil
      self.password   = nil
      self.public_key = nil
      self.secret_key = nil
      true
    end
  end
end
