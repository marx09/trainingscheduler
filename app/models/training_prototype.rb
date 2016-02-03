class TrainingPrototype < ActiveRecord::Base
  belongs_to :group
  has_many :trainings
  
  validates :day, presence: true
  validates :from, presence: true
end
