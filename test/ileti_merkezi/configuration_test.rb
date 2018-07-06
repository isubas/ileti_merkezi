require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_that_it_has_a_endpoint
    refute_nil IletiMerkezi::Configuration::ENDPOINT
  end

  def test_that_it_has_a_sender
    refute_nil IletiMerkezi::Configuration::SENDER
  end

  def test_auth_method_for_basic
    config = IletiMerkezi::Configuration.new
    config.reset
    config.username = 'username'
    config.password = 'password'

    assert_equal(config.auth_method, :auth_basic)
  end

  def test_auth_method_for_token
    config = IletiMerkezi::Configuration.new
    config.reset
    config.public_key = 'public_key'
    config.secret_key = 'secret_key'

    assert_equal(config.auth_method, :auth_token)
  end

  def test_hmac
    config = IletiMerkezi::Configuration.new
    config.public_key = 'public_key'
    config.secret_key = 'secret_key'
    hmac = 'b6a736a4b6739ac56db7e903b0ef55bda82fca63fac55d4bd1d6d62c54888b22'

    assert_equal(config.hmac, hmac)
  end

  def test_raises_error_when_credential_missing
    assert_raises IletiMerkezi::CredentialMissingError do
      config = IletiMerkezi::Configuration.new
      config.reset
      config.auth_method
    end
  end
end
