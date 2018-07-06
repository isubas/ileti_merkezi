require 'test_helper'

class ReportTest < Minitest::Test
  def test_that_it_has_a_path
    refute_nil IletiMerkezi::Report::PATH
  end

  def test_content
    report = IletiMerkezi::Report.new(100)

    content = <<-XML.gsub(/^[ ]+/, '').strip
    <id>100</id>
    <page>1</page>
    <rowCount>1000</rowCount>
    XML

    assert_equal report.send(:content), content
  end

  def test_query
    VCR.use_cassette('report') do
      response = IletiMerkezi::Report.new(51502516)
                                     .query
      assert_match(/<response>/, response.body)
    end
  end
end
