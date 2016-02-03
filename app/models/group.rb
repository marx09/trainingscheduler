class Group < ActiveRecord::Base
  has_many :users
  has_many :training_prototypes
  
  validates :name, presence: true
  
  resourcify
end
