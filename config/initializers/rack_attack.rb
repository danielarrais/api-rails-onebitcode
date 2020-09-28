module Rack
  class Attack
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    # Permite tráfego local
    safelist('allow-localhost') do |req|
      '127.0.0.1' == req.ip || '::1' == req.ip
    end

    # Permite 5 requisições a cada 5 segundos
    throttle('req/ip', limit: 5, period: 5) do |req|
      req.ip
    end

    # Limita quantidade de tentativas de login
    #throttle("logins/email", limit: 5, period: 20.seconds) do |req|
    #  if req.path == '/users/sign_in' && req.post?
    #    req.params['email'].presence
    #  end
    #end

  end
end
