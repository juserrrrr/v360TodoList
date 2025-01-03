module Authentication
  extend ActiveSupport::Concern

  # Esse bloco de código é executado quando o módulo é incluído em um controller
  included do
    before_action :require_authentication # Carrega o método require_authentication antes de qualquer ação do controller
    helper_method :authenticated?, :current_user # Torna os métodos authenticated? e current_user disponíveis para as views
  end

  # Esse bloco de código é executado quando o módulo é extendido em um controller
  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end

    def redirect_authenticated_user(**options)
      before_action :redirect_authenticated_user, **options
    end
  end

  # Esse bloco de código é executado quando o módulo é incluído em um controller
  private
    def authenticated?
      resume_session
    end

  private
    def current_user
      Current.session&.user
    end
    # Método que verifica se o usuário está autenticado
    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end
    # Método que redireciona o usuário para a página de login
    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end
    # Método que redireciona o usuário para a página de listas caso ele esteja autenticado
    def redirect_authenticated_user
      redirect_to lists_path if authenticated?
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || lists_path
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end

