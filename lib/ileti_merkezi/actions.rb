# frozen_string_literal: true

%w[
  account
  balance
  cancel
  report
  sms
].each { |file| require_relative "./actions/#{file}" }
