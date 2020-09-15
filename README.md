[![Maintainability](https://api.codeclimate.com/v1/badges/b427c95759e1dca1e3dc/maintainability)](https://codeclimate.com/github/isubas/ileti_merkezi/maintainability)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/cecce51ce4d94f3ca1dcc1e99bdcbce6)](https://www.codacy.com/app/isubas/ileti_merkezi?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=isubas/ileti_merkezi&amp;utm_campaign=Badge_Coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/cecce51ce4d94f3ca1dcc1e99bdcbce6)](https://www.codacy.com/app/isubas/ileti_merkezi?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=isubas/ileti_merkezi&amp;utm_campaign=Badge_Grade)
[![](https://github.com/isubas/ileti_merkezi/workflows/test/badge.svg)](https://github.com/isubas/ileti_merkezi/actions)
[![Known Vulnerabilities](https://snyk.io/test/github/isubas/ileti_merkezi/badge.svg?targetFile=Gemfile.lock)](https://snyk.io/test/github/isubas/ileti_merkezi?targetFile=Gemfile.lock)

# IletiMerkezi
iletimerkezi.com API'lerini kullanarak toplu sms gönderme ve raporlama
işlemlerini yapabilmek için hazırlanan Ruby istemcisidir.

## Kurulum

Bu satırı Gemfile dosyasına ekleyin.

```ruby
gem 'ileti_merkezi'
```

Ardından aşağıdaki komutu çalıştırın:

    $ bundle

Veya kendiniz aşağıdaki komut ile sisteme kurabilirsiniz:

    $ gem install ileti_merkezi

## Kullanım

### Yapılandırma

Rails uygulamanızda `config/initializers/ileti_merkezi_configure.rb` dosyası oluşturarak
aşağıdaki kodları içerisine yapıştırınız.

Eğer kimlik doğrulama işlemini kullanıcı adı ve parola üzerinden yapmak istiyorsanız username ve password bilgilerini,
token tabanlı yapmak istiyorsanız public_key ve secret_key bilgilerini doldurmanız gerekmektedir.

Bu dört alanda doldurulmuş ise sistem token tabanlı doğrulama yapacaktır.

public ve secret key bilgilerini https://www.iletimerkezi.com/user/preferences adresinden oluşturabilirsiniz.

```ruby
IletiMerkezi.configure do |config|
  # Default: http://api.iletimerkezi.com/v1'
  config.endpoint          = 'http://api.iletimerkezi.com/v1'
  config.sender            = 'FOO'
  # opsiyonel
  config.request_overrides = {
    use_ssl: true, # default false
    verify_mode: OpenSSL::SSL::VERIFY_PEER,
    read_timeout: 30, # default 30
    open_timeout: 30 # default 30
  }
  # Kimlik Doğrulama: username ve password
  config.username = 'username'
  config.password = 'password'
  # Kimlik Doğrulama: token tabanlı
  config.public_key = 'public_key'
  config.secret_key = 'secret_key'
end
```

Veya

- Ortam değişkeleri ile yapılandırabilirsiniz. bknz: .env

```ruby
IM_ENDPOINT = 'http://api.iletimerkezi.com/v1' # Default: http://api.iletimerkezi.com/v1
# Kimlik Doğrulama: username ve password
IM_USERNAME = 'username'
IM_PASSWORD = 'password'
# Kimlik Doğrulama: token tabanlı
IM_PUBLIC_KEY = 'public_key'
IM_SECRET_KEY = 'secret_key'

IM_SENDER = 'SENDER'
```

### SMS Gönderme

#### Tek Mesaj - Çoklu Alıcı

```ruby

  args = {
    send_datetime: '15/01/2017 12:00', # Opsiyonel
    sender: 'TEST', # Opsiyonel
    phones: ['0555 555 00 01', '0555 555 00 02'],
    text: 'Test Mesajı'
  }

  # return IletiMerkezi::Response
  response = IletiMerkezi.send(args)
  # veya
  sms      = IletiMerkezi::Sms.new(args)
  response = sms.send

  response.code # return 200
  response.body # http raw body
  response.message # return status message
  response.error? # return true or false
  response.to_h
  # return hash
  {
    :status => {
      :code => "200",
      :message => "İşlem başarılı"
    },
    :order => {
      :id => "order_id"
    }
  }
```

#### Çoklu Mesaj - Çoklu Alıcı

```ruby
  args = {
    send_datetime: '15/01/2017 12:00', # Opsiyonel
    sender: 'TEST', # Opsiyonel
    messages: [
      {
        text: 'Test Mesajı Bir',
        phones: ['0555 555 00 01', '0555 555 00 02'],
      },
      {
        text: 'Test Mesajı İki',
        phones: ['0555 555 00 03', '0555 555 00 04'],
      }
    ]
  }

  # return IletiMerkezi::Response
  response = IletiMerkezi.send(args)
  # veya
  sms      = IletiMerkezi::Sms.new(args)
  response = sms.send

  response.code # return 200
  response.body # http raw body
  response.message # return status message
  response.error? # return true or false
  response.to_h
  # return hash
  {
    :status => {
      :code => "200",
      :message => "İşlem başarılı"
    },
    :order => {
      :id => "order_id"
    }
  }
```

### Zamanlamış SMS Gönderim İptali

- **Not**: Yalnız gelecek ki bir zamanda gönderilecek sms siparişleri iptal edilebilir.

```ruby
  # return IletiMerkezi::Response
  response = IletiMerkezi.cancel(order_id)
  # veya
  cancel   = IletiMerkezi::Cancel.new(order_id)
  response = cancel.confirm

  response.code # return 200
  response.body # http raw body
  response.message # return status message
  response.error? # return true or false
  response.to_h
  # return hash
  {
    :status => {
      :code => "200",
      :message => "İşlem başarılı"
    }
  }

```

#### Bakiye Sorgulama

```ruby
  # return IletiMerkezi::Response
  response = IletiMerkezi.balance

  response.code # return 200
  response.body # http raw body
  response.message # return status message
  response.error? # return true or false
  response.to_h
  # return
  {
    :status => {
      :code => "200",
      :message => "İşlem başarılı"
    },
    :balance => {
      :amount => "1",
      :sms => "238760"
    }
  }
```

### SMS Sipariş Raporlama

#### Ek Bilgi:

  - **page**: zorunlu değildir. Bir siparişteki alıcı sayısı row_count(1000)'den fazla
             ise page parametresi kullanılarak diğer rapor sayfaları için istek yapılabilir.
  - **row_count**: Bir sayfada göntülenecek rapor sayısı

```ruby
  # return IletiMerkezi::Response
  response = IletiMerkezi.report(order_id, page: 1, row_count: 1000) # defaults: (page: 1, row_count: 1000)
  # veya
  report   = IletiMerkezi::Report.new(order_id, page: 1, row_count: 1000)
  response = report.query

  response.code # return 200
  response.body # http raw body
  response.message # return status message
  response.error? # return true or false
  response.to_h
  # return hash
  {
    :status => {
      :code => "200",
      :message =>"İşlem başarılı"
    },
    :order => {
      :id => "order_id",
      :status => "114",
      :total => "1",
      :delivered => "1",
      :undelivered => nil,
      :waiting => nil,
      :submitAt => "2018-01-16 15:08:37",
      :sendAt => "2018-01-16 15:08:00",
      :sender => "OMU UZEM",
      :price => "1",
      :status => "114",
      :message => [
        { :number=>"+9055XXXXXXXX", :status=>"111" },
        { :number=>"+9055XXXXXXXX", :status=>"111" }
      ]
    }
  }
```

### Servis Durumu

```ruby
  IletiMerkezi.status # return true or false
```

### Hesap Bilgileri

**Not:** Kullanıcı adı ve paralo bilgilerinin yapılandırmada doldurulmuş olması gerekmektedir.

```ruby
  IletiMerkezi.info
```

### Hesabınıza Tanımlı Başlık Bilgileri

**Not:** Kullanıcı adı ve paralo bilgilerinin yapılandırmada doldurulmuş olması gerekmektedir.

```ruby
  IletiMerkezi.senders
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/isubas/ileti_merkezi.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the IletiMerkezi project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/isubas/ileti_merkezi/blob/master/CODE_OF_CONDUCT.md).
