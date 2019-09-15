# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # Create CSR or import existing SSL Certificate
    #
    # @see https://developers.files.com/#create-csr-or-import-existing-ssl-certificate Create CSR or import existing SSL Certificate
    #
    class CreateCertificate
      include Command
      using BrickFTP::CoreExt::Struct
      using BrickFTP::CoreExt::Hash

      # PARAMETER                     | TYPE    | DESCRIPTION
      # ----------------------------- | ------- | -----------
      # name                          | string  | Required: Internal name of the SSL certificate.
      # certificate_domain            | string  | Domain for certificate.
      # certificate_country           | string  | Country.
      # certificate_state_or_province | string  | State or province.
      # certificate_city_or_locale    | string  | City or locale.
      # certificate_company_name      | string  | Company name.
      # csr_ou1                       | string  | Department name or organization unit 1
      # csr_ou2                       | string  | Department name or organization unit 2
      # csr_ou3                       | string  | Department name or organization unit 3
      # certificate_email_address     | string  | Email address for the certificate owner.
      # key_type                      | string  | Any supported key type. Defaults to RSA-4096.
      # key_type_confirm_given        | string  | Confirms the key type.
      # certificate                   | string  | The certificate. PEM or PKCS7 formats accepted.
      # private_key                   | string  | Certificate private key.
      # password                      | string  | Certificate password.
      # intermediates                 | string  | Intermediate certificates. PEM or PKCS7 formats accepted.
      Params = Struct.new(
        'CreateCertificateParams',
        :name,
        :certificate_domain,
        :certificate_country,
        :certificate_state_or_province,
        :certificate_city_or_locale,
        :certificate_company_name,
        :csr_ou1,
        :csr_ou2,
        :csr_ou3,
        :certificate_email_address,
        :key_type,
        :key_type_confirm_given,
        :certificate,
        :private_key,
        :password,
        :intermediates,
        keyword_init: true
      )

      # Create CSR or import existing SSL Certificate
      #
      # @param [BrickFTP::RESTfulAPI::CreateCertificate::Params] params parameters
      # @return [BrickFTP::Types::::Params]
      #
      def call(params = {})
        res = client.post('/api/rest/v1/certificates.json', Params.new(params.to_h).to_h.compact)

        BrickFTP::Types::Certificate.new(res.symbolize_keys)
      end
    end
  end
end
