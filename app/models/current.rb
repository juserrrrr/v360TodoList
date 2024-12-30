class Current < ActiveSupport::CurrentAttributes
  # Define um atributo para a sessão atual
  attribute :session
  
  # Delegação para acessar o usuário através da sessão, permitindo valores nulos
  delegate :user, to: :session, allow_nil: true
end
