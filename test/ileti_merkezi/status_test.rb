require 'test_helper'

class StatusTest < Minitest::Test
  def test_find
    status = IletiMerkezi::Status.find(200)

    assert_equal status.code, 200
    assert_equal status.message, 'İşlem başarılı'
    assert_equal status.type, :info
  end

  def test_error?
    status = IletiMerkezi::Status.find(400)

    assert status.error?
  end

  def test_info?
    status = IletiMerkezi::Status.find(200)

    assert status.info?
  end
end
