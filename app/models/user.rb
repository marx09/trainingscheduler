class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_and_belongs_to_many :trainings
  has_many :results
  has_many :training_results
  
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '50x50>' },
                             default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
end
