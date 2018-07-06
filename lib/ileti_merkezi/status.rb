# frozen_string_literal: true

module IletiMerkezi
  # Status
  class Status
    CODES = {
      110 => { type: :info, message: 'Mesaj gönderiliyor' },
      111 => { type: :info, message: 'Mesaj gönderildi' },
      112 => { type: :error, message: 'Mesaj gönderilemedi' },
      113 => { type: :info, message: 'Siparişin gönderimi devam ediyor' },
      114 => { type: :info, message: 'Siparişin gönderimi tamamlandı' },
      115 => { type: :info, message: 'Sipariş gönderilemedi' },
      200 => { type: :info, message: 'İşlem başarılı' },
      400 => { type: :error, message: 'İstek çözümlenemedi' },
      401 => { type: :error, message: 'Üyelik bilgileri hatalı' },
      402 => { type: :error, message: 'Bakiye yetersiz' },
      404 => { type: :error, message: 'API istek yapılan yönteme sahip değil' },
      450 => { type: :error, message: 'Gönderilen başlık kullanıma uygun değil' },
      451 => { type: :error, message: 'Tekrar eden sipariş' },
      452 => { type: :error, message: 'Mesaj alıcıları hatalı' },
      453 => { type: :error, message: 'Sipariş boyutu aşıldı' },
      454 => { type: :error, message: 'Mesaj metni boş' },
      455 => { type: :error, message: 'Sipariş bulunamadı' },
      456 => { type: :info, message: 'Sipariş gönderim tarihi henüz gelmedi' },
      457 => { type: :error, message: 'Mesaj gönderim tarihinin formatı hatalı' },
      503 => { type: :error, message: 'Sunucu geçici olarak servis dışı' }
    }.freeze

    attr_reader :code, :type, :message

    def initialize(options = {})
      @code    = options[:code].to_i
      @type    = options[:type]
      @message = options[:message]
    end

    def self.find(code)
      value = CODES[code.to_i] || {}
      new(value.merge(code: code))
    end

    def error?
      type == :error
    end

    def info?
      type == :info
    end

    def success?
      info?
    end
  end
end
