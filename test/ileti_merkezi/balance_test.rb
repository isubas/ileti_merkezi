require 'test_helper'

class BalanceTest < Minitest::Test
  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Balance::PATH
  end

  def test_query
    VCR.use_cassette('balance') do
      response = IletiMerkezi::Balance.query
      assert_equal(
        response.status.message,
        IletiMerkezi::Status::CODES[response.code][:message]
      )

      assert_match(/<response>/, response.body)
    end
  end
end
