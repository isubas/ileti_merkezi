require 'test_helper'

class CancelTest < Minitest::Test
  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Cancel::PATH
  end

  def test_confirm
    VCR.use_cassette('cancel') do
      response = IletiMerkezi::Cancel.new(100)
                                     .confirm
      assert_match(/<response>/, response.body)
    end
  end
end
