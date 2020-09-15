# frozen_string_literal: true

module IletiMerkezi
  # Report
  class Report
    include XmlBuilder
    PATH = '/get-report'

    attr_reader :order_id, :page, :row_count

    def initialize(order_id, page: 1, row_count: 1000)
      @order_id  = order_id
      @page      = page
      @row_count = row_count
    end

    def query
      request = Request.new(
        path: PATH,
        payload: hash_to_xml(
          id: order_id,
          page: page,
          row_count: row_count
        )
      )
      request.call
    end
  end
end
