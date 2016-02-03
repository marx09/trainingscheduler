class Template < ActiveRecord::Base
  has_many :slots
  
  validates :name, presence: true
end
