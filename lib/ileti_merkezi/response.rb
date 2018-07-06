# frozen_string_literal: true

require 'forwardable'

module IletiMerkezi
  # Response
  class Response
    extend Forwardable

    def_delegators :status, :message, :error?, :info?, :success?

    attr_reader :response, :code, :body

    def initialize(response)
      @response = response
      @code     = response.code.to_i
      @body     = response.body
    end

    def status
      Status.find(code)
    end

    def to_h
      hash = Ox.load(
        body.force_encoding('utf-8'),
        mode: :hash
      )
      hash.fetch(:response, hash)
    rescue Ox::ParseError
      {}
    end

    alias to_hash to_h
  end
end
