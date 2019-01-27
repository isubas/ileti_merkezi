require 'test_helper'

class AuthenticationTest < Minitest::Test
  def test_auth_basic
    config = IletiMerkezi.configuration
    config.username = 'username'
    config.password = 'password'
    hash = { username: 'username', password: 'password' }

    assert_equal(IletiMerkezi::Authentication.auth_basic, hash)
    config.default_config
  end

  def test_auth_token
    config = IletiMerkezi.configuration
    config.public_key = 'public_key'
    config.secret_key = 'secret_key'
    hmac = 'b6a736a4b6739ac56db7e903b0ef55bda82fca63fac55d4bd1d6d62c54888b22'
    hash = { key: 'public_key', hash: hmac }

    assert_equal(IletiMerkezi::Authentication.auth_token, hash)
    config.default_config
  end
end
