# frozen_string_literal: true

module IletiMerkezi
  # Report
  class Report
    PATH = '/get-report'.freeze

    attr_reader :order_id, :page, :row_count

    def initialize(order_id, page: 1, row_count: 1000)
      @order_id  = order_id
      @page      = page
      @row_count = row_count
    end

    def query
      request = Request.new(content: content, path: PATH)
      request.call
    end

    private

    def content
      <<-XML.gsub(/^[ ]+/, '').strip
      <id>#{order_id}</id>
      <page>#{page}</page>
      <rowCount>#{row_count}</rowCount>
      XML
    end
  end
end
