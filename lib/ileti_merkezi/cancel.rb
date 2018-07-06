# frozen_string_literal: true

module IletiMerkezi
  # Cancel
  class Cancel
    PATH = '/cancel-order'.freeze

    attr_reader :order_id

    def initialize(order_id)
      @order_id = order_id
    end

    def confirm
      request = Request.new(content: content, path: PATH)
      request.call
    end

    private

    def content
      "<id>#{order_id}</id>"
    end
  end
end
