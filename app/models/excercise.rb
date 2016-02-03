class Excercise < ActiveRecord::Base
  has_many :series, class_name: "Serie"
  
  validates :name, presence: true
end
