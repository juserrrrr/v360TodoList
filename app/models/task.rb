class Task < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validates :list_id, presence: true
  validates :is_completed, inclusion: { in: [ true, false ] }
end
