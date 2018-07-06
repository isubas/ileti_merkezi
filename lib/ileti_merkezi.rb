# frozen_string_literal: true

require 'net/http'
require 'ox'

files = %w[
  version
  error
  configuration
  account
  authentication
  balance
  cancel
  message
  request
  report
  response
  sms
  status
]

files.each { |path| require_relative "./ileti_merkezi/#{path}" }

# IletiMerkezi
module IletiMerkezi
  class << self
    # :reek:Attribute
    attr_writer :configuration
  end

  module_function

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield(configuration)
  end

  # Helper Methods

  # Get balance information
  #
  # @return [IletiMerkezi::Response]
  #
  # @api public
  def balance
    Balance.query
  end

  # Sms order cancellation
  #
  # @param order_id [Integer] Sms order id
  #
  # @return [IletiMerkezi::Response]
  #
  # @api public
  def cancel(order_id)
    Cancel.new(order_id).confirm
  end

  # Find status with code id
  #
  # @param code_id [Integer] Http status code
  #
  # @return [IletiMerkezi::Status]
  #
  # @api public
  def code(code_id)
    Status.find(code_id)
  end

  # Get account information
  #
  # @return [Hash]
  # {
  #   name_surname: 'name-surname',
  #   tc_number: nil,
  #   title: nil,
  #   email: 'email',
  #   gsm: 'phone',
  #   password: 'password',
  #   commercial_title: nil,
  #   gsm2: nil,
  #   phone_number: nil,
  #   fax_number: nil,
  #   bill_address: nil,
  #   zone: nil,
  #   city: nil,
  #   zip: nil,
  #   charge_home: nil,
  #   charge_number: nil
  # }
  #
  # @api public
  def info
    response = Account.info
    response.to_h.fetch(:userInfo, {})
  end

  # Get Sms order report
  #
  # @param order_id [Integer], page [Integer], row_count [Integer]
  #
  # @return [IletiMerkezi::Response]
  #
  # @api public
  def report(order_id, page: 1, row_count: 1000)
    Report.new(order_id,
               page: page,
               row_count: row_count).query
  end

  # Sms send method
  #
  # @param args [Hash]
  #
  # @return [IletiMerkezi::Response]
  #
  # Example:
  #
  # args1 = {
  #   send_datetime: '15/01/2017 12:00' # Opsiyonel
  #   sender: 'TEST' # Opsiyonel
  #   phones: ['0555 555 00 01', '0555 555 00 02']
  #   text: 'Test Message'
  # }
  #
  # args2 = {
  #   send_datetime: '15/01/2017 12:00' # Opsiyonel
  #   sender: 'TEST' # Opsiyonel
  #   messages: [
  #     {
  #       text: 'First Test Message',
  #       phones: ['0555 555 00 01', '0555 555 00 02'],
  #     },
  #     {
  #       text: 'Second Test Message',
  #       phones: ['0555 555 00 03', '0555 555 00 04'],
  #     }
  #   ]
  # }
  #
  # response = IletiMerkezi.send(args1)
  # or
  # response = IletiMerkezi.send(args2)
  #
  # @api public
  def send(args)
    Sms.new(args).send
  end

  # Get senders
  #
  # @return [Hash]
  #
  # @api public
  def senders
    response = Account.senders
    response.to_h.fetch(:smsHeaderInfo, {})
  end

  # Get Service Status
  #
  # @return [Boolean]
  #
  # @api public
  def status
    balance.code == 200
  end
end
