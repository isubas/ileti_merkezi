require 'test_helper'

class MessageTest < Minitest::Test
  def setup
    @message = IletiMerkezi::Message.new(
      %w[1111 2222], 'Test Message'
    )
  end

  def test_valid
    assert(@message.valid?)
  end

  def test_invalid_without_phones
    invalid_message = IletiMerkezi::Message.new(
      nil, 'Test Message'
    )
    refute(invalid_message.valid?)
  end

  def test_invalid_without_message
    invalid_message = IletiMerkezi::Message.new(
      ['05XX XXX XX XX'], nil
    )
    refute(invalid_message.valid?)
  end

  def test_to_hash
    hash = {
      text: 'Test Message',
      receipents: {
        number: ['1111', '2222']
      }
    }
    assert_equal @message.to_hash, hash
  end

  def test_raises_error_when_message_is_invalid
    assert_raises IletiMerkezi::InvalidMessageError do
      message = IletiMerkezi::Message.new(nil, 'Test Message')
      message.to_hash
    end
  end
end
