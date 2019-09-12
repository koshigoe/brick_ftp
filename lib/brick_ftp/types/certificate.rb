# frozen_string_literal: true

module BrickFTP
  module Types
    using BrickFTP::CoreExt::Struct

    # The Certificate object
    #
    # @see https://developers.files.com/#the-certificate-object The Certificate object
    #
    # ATTRIBUTE          | TYPE     | DESCRIPTION
    # ------------------ | -------- | -----------
    # id                 | integer  | Certificate ID
    # certificate        | string   | Full text of SSL certificate
    # created_at         | datetime | Certificate created at
    # display_status     | string   | Certificate status. (One of `Request Generated`, `New`, `Active`, `Active/Expired`, `Expired`, or `Available`)
    # domains            | array    | Domains on this certificate other than files.com domains
    # expires_at         | datetime | Certificate expiration date/time
    # brick_managed      | boolean  | Is this certificate automatically managed and renewed by Files.com?
    # intermediates      | string   | Intermediate certificates
    # ip_addresses       | array    | A list of IP addresses associated with this SSL Certificate
    # issuer             | string   | X509 issuer
    # name               | string   | Descriptive name of certificate
    # key_type           | string   | Type of key
    # request            | string   | Certificate signing request text
    # status             | string   | Certificate status (Request Generated, New, Active, Active/Expired, Expired, or Available)
    # subject            | string   | X509 Subject name
    # updated_at         | datetime | Certificated last updated at
    #
    Certificate = Struct.new(
      'Certificate',
      :id,
      :certificate,
      :created_at,
      :display_status,
      :domains,
      :expires_at,
      :brick_managed,
      :intermediates,
      :ip_addresses,
      :issuer,
      :name,
      :key_type,
      :request,
      :status,
      :subject,
      :updated_at,
      keyword_init: true
    ) do
      prepend IgnoreUndefinedAttributes
    end
  end
end
