require 'test_helper'

class AuthenticationTest < Minitest::Test
  def test_auth_basic
    config = IletiMerkezi.configuration
    config.username = 'username'
    config.password = 'password'

    xml = <<-XML.gsub(/^[ ]+/, '').strip
    <authentication>
      <username>username</username>
      <password>password</password>
    </authentication>
    XML

    assert_equal(IletiMerkezi::Authentication.auth_basic, xml)
    config.default_config
  end

  def test_auth_token
    config = IletiMerkezi.configuration
    config.public_key = 'public_key'
    config.secret_key = 'secret_key'

    hmac = 'b6a736a4b6739ac56db7e903b0ef55bda82fca63fac55d4bd1d6d62c54888b22'
    xml = <<-XML.gsub(/^[ ]+/, '').strip
    <authentication>
      <key>public_key</key>
      <hash>#{hmac}</hash>
    </authentication>
    XML

    assert_equal(IletiMerkezi::Authentication.auth_token, xml)
    config.default_config
  end
end
