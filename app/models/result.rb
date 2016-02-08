# Result
class Result < ActiveRecord::Base
  belongs_to :serie
  belongs_to :user
  has_one :excercise, through: :serie

  resourcify
end
