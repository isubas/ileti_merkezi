# frozen_string_literal: true

module IletiMerkezi
  # Cancel
  class Cancel
    include XmlBuilder

    PATH = '/cancel-order'

    attr_reader :order_id

    def initialize(order_id)
      @order_id = order_id
    end

    def confirm
      request = Request.new(
        path: PATH,
        payload: hash_to_xml(id: order_id)
      )
      request.call
    end
  end
end
