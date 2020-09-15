# frozen_string_literal: true

module IletiMerkezi
  # Balance
  module Balance
    PATH = '/get-balance'

    module_function

    def query
      request = Request.new(path: PATH)
      request.call
    end
  end
end
