class ApplicationController < ActionController::Base
  # Incluir módulo de autenticação
  include Authentication
  # Permitir apenas navegadores modernos que suportam imagens webp, push web, badges, import maps, aninhamento de CSS e CSS :has.
  allow_browser versions: :modern
end
