require 'omniauth'
require 'base64'
require 'omniauth/strategies/nordea/request_helpers'

module OmniAuth
  module Strategies
    class Nordea
      PRODUCTION_ENDPOINT = "https://netbank.nordea.com/pnbeid/eidn.jsp"
      TEST_ENDPOINT = "https://netbank.nordea.com/pnbeidtest/eidn.jsp"

      include OmniAuth::Strategy

      args [:rcvid, :mac]

      option :rcvid, nil
      option :mac, nil

      # Supported algorithms: :sha1 and :md5
      option :hash_algorithm, :sha1
      option :name, "nordea"
      option :endpoint, PRODUCTION_ENDPOINT

      uid do
        request.params["B02K_CUSTID"].dup.insert(6, "-")
      end

      info do
        {
          full_name: request.params["B02K_CUSTNAME"].split(" ").reverse.join(" ")
        }
      end

      extra do
        { raw_info: request.params }
      end

      def callback_phase
        if request.params["B02K_CUSTID"] && !request.params["B02K_CUSTID"].empty?
          super
        else
          fail!(:invalid_credentials)
        end
      end

      def request_phase
        param_hash = OmniAuth::Strategies::Nordea.build_request_hash(options.rcvid, options.mac,
          full_host + script_name + callback_path, algorithm: options.hash_algorithm)
        OmniAuth::Strategies::Nordea.sign_hash_in_place(param_hash)

        # Build redirect form
        form = OmniAuth::Form.new(title: I18n.t("omniauth.nordea.please_wait"), url: options.endpoint)

        param_hash.each_pair do |k,v|
          form.html "<input type=\"hidden\" name=\"#{k}\" value=\"#{v}\" />"
        end

        form.button I18n.t("omniauth.nordea.click_here_if_not_redirected")

        form.instance_variable_set("@html",
          form.to_html.gsub("</form>", "</form><script type=\"text/javascript\">document.forms[0].submit();</script>"))
        form.to_response
      end
    end
  end
end
