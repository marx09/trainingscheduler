class Serie < ActiveRecord::Base
  
  belongs_to :slot
  belongs_to :excercise
  
  has_many :results
  has_many :users, :through => :result
end
