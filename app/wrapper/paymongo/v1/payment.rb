module Paymongo
    module V1
        class Payment
            BASE_URL = "https://api.paymongo.com/v1".freeze
            SECRET_KEY = Rails.application.credentials.paymongo_secret_key
            HEADERS = { 'Content-Type': 'application/json', Authorization: "Basic #{Base64.encode64(SECRET_KEY)}" }

            def create_payment_intent(info)
                response = send_request(:post, 'payment_intents', intent_params(info))
                data = response['data']['attributes']['client_key'].split('_client')
                {id: data.first, client_key: data.last}
            end
    
            def create_payment_method(info)
                response = send_request(:post, 'payment_methods', method_params(info))
                {id: response['data']['id']}
            end
    
            def proceed(info)
                intent = self.create_payment_intent(info)
                method = self.create_payment_method(info)
                response = send_request(:post, "payment_intents/#{intent[:id]}/attach", attach_params(method[:id], intent[:client_key]))
                response['data']['attributes']['status']
            end
    
            private
        
            def send_request(http_method, endpoint, params = {})
                @response = connection.public_send(http_method, endpoint, params)
                JSON.parse(@response.body)
            end
        
            def connection
                @connection = Faraday.new( url: BASE_URL, headers: HEADERS )
            end
        
            def intent_params(info)
                {
                    data: {
                        attributes: {
                            amount: info[:price].to_i,
                            payment_method_allowed: ['card'],
                            payment_method_options: {
                                card: { request_three_d_secure: 'any' }
                            },
                            currency: 'PHP',
                            description: "#{info[:plan].capitalize} subscription to Likha"
                        }
                    }
                }.to_json
            end
    
            def method_params(info)
                {
                    data: {
                        attributes: {
                          details: {
                            card_number: info[:card_number],
                            exp_month: info[:exp_month].to_i,
                            exp_year: info[:exp_year].to_i,
                            cvc: info[:cvc],
                          }, 
                          type: 'card', 
                          billing: {
                            name: info[:name], 
                            email: info[:email]
                          }
                        }
                    }
                }.to_json
            end
    
            def attach_params(method_id, client_key)
                {
                    data: {
                        attributes: {
                          payment_method: method_id, 
                          client_key: client_key,
                        }
                    }
                }.to_json
            end
        end
    end
end