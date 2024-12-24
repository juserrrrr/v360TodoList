class Task < ApplicationRecord
  belongs_to :list
  validate :name, presence: true
  validate :list_id, presence: true
  validates :is_completed, inclusion: { in: [ true, false ] }
end
