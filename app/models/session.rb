class Session < ApplicationRecord
  # Define relacionamento de muitos-para-um com usuários
  belongs_to :user
end
