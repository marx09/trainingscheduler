# Training result
class TrainingResult < ActiveRecord::Base
  belongs_to :training
  belongs_to :user

  resourcify
end
