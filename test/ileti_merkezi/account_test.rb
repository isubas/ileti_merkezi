require 'test_helper'

class AccountTest < Minitest::Test
  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Account::PATH
  end

  def test_info
    VCR.use_cassette('account_info') do
      response = IletiMerkezi::Account.info
      assert_match(/<userInfo>/, response.body)
    end
  end

  def test_senders
    VCR.use_cassette('account_senders') do
      response = IletiMerkezi::Account.senders
      assert_match(/<headerInfo>/, response.body)
    end
  end
end
