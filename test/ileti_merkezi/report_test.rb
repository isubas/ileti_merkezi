require 'test_helper'

class ReportTest < Minitest::Test
  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Report::PATH
  end

  def test_query
    VCR.use_cassette('report') do
      response = IletiMerkezi::Report.new(1)
                                     .query
      assert_match(/<response>/, response.body)
    end
  end
end
