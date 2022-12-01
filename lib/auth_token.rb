
# frozen_string_literal: true

require 'jwt'

class AuthToken

  def initialize
    @hmac_secret = Rails.application.credentials.jwt_secret_key
    @alg = Rails.application.credentials.jwt_alg
  end

  def encode(payload)
    # Will come from env in actual application

    JWT.encode payload, @hmac_secret, @alg
    # JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decode(token)
    # decoded_token looks like [{"user"=>"25063d8a-8994-449b-adde-f62230da7fbb"}, {"@alg"=>"HS256"}]
    JWT.decode(token, @hmac_secret, true, { algorithm: @alg }).first
    # JWT.decode(token, Rails.application.credentials.secret_key_base).first
  rescue StandardError
    nil
  end

  def valid?(token)
    decode(token).present?
  end

  def expired?(payload)
    return true if payload && payload['exp'].blank?

    Time.at(payload['exp']) < Time.now
  end

end