require 'test_helper'

class SmsTest < Minitest::Test
  def setup
    IletiMerkezi.configuration = IletiMerkezi::Configuration.new

    @sms = IletiMerkezi::Sms.new(
      sender: 'TEST',
      send_datetime: '13/01/2018 22:22',
      text: 'Test Message',
      phones: [TEST_PHONE]
    )
  end

  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Sms::PATH
  end

  def test_messages_is_array
    assert_kind_of Array, @sms.messages
  end

  def test_messages
    assert_equal @sms.messages.size, 1
  end

  def test_sender
    assert_equal @sms.sender, 'TEST'

    sms = IletiMerkezi::Sms.new({})

    assert_equal sms.sender, 'APITEST'
  end

  def test_send_datetime
    assert_equal @sms.send_datetime, '13/01/2018 22:22'

    sms      = IletiMerkezi::Sms.new({})
    datetime = Time.now.strftime('%d/%m/%Y %H:%M')

    assert_equal sms.send_datetime, datetime
  end

  def test_single_message_send
    sms = IletiMerkezi::Sms.new(
      text: 'Test Message',
      phones: [TEST_PHONE]
    )

    VCR.use_cassette('sms_single_mesage_send') do
      response = sms.send
      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end

  def test_multi_messages_send
    sms = IletiMerkezi::Sms.new(
      messages: [
        {
          text: 'First Test Message',
          phones: [TEST_PHONE]
        },
        {
          text: 'Second Test Message',
          phones: [TEST_PHONE]
        }
      ]
    )

    VCR.use_cassette('sms_multi_mesages_send') do
      response = sms.send
      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end
end
