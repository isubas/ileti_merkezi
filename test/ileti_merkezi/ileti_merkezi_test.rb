require 'test_helper'

class IletiMerkeziTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::IletiMerkezi::VERSION
  end

  def test_balance
    VCR.use_cassette('balance') do
      response = IletiMerkezi.balance
      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end

  def test_cancel
    VCR.use_cassette('cancel') do
      response = IletiMerkezi.cancel(100)
      assert_match(/<response>/, response.body)
    end
  end

  def test_info
    VCR.use_cassette('account_info') do
      info = IletiMerkezi.info
      assert_equal info.fetch(:name_surname), 'Name'
    end
  end

  def test_report
    VCR.use_cassette('report') do
      response = IletiMerkezi.report(100, page: 1, row_count: 1000)

      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end

  def test_send
    VCR.use_cassette('sms_single_mesage_send') do
      args = {
        text: 'Test',
        phones: ['0551 XXX XX XX']
      }

      response = IletiMerkezi.send(args)

      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end

  def test_senders
    VCR.use_cassette('account_senders') do
      senders = IletiMerkezi.senders
      assert_equal senders.fetch(:headerInfo), ['BAR', 'FOO']
    end
  end
end
