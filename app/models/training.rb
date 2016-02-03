class Training < ActiveRecord::Base
  attr_accessor :data_hash
  attr_accessor :users_hash
  
  before_save :process_data_hash
  before_save :process_users_hash
  before_save :check_prototype
  
  has_and_belongs_to_many :users
  has_many :slots
  belongs_to :training_prototype
  has_many :training_results
  
  validates :date, presence: true
  validates :from, presence: true
  
  private
  
  def process_data_hash
    if data_hash && data_hash['slots']
      slots_collection = []
      data_hash['slots'].each do |s|
        if s['id'].to_i > 0
          slot = Slot.find(s['id'].to_i)
        else
          slot = Slot.new()
        end
        slot.data_hash = s['series']
        slot.note = s['note']
        slot.order = s['order'].to_i
        slot.save
        slots_collection << slot
      end
      self.slots = slots_collection
      Slot.where(training: nil).destroy_all
    end
  end
  
  def process_users_hash
    if users_hash && users_hash['users']
      users_collection = []
      users_hash['users'].each do |u|
        if u['id'].to_i > 0
          user = User.find(u['id'].to_i)
          users_collection << user if user
        end
      end
      self.users = users_collection
    end
  end
  
  def check_prototype
    if self.training_prototype && (self.from_prototype_at != self.date || self.from != self.training_prototype.from)
      self.training_prototype = nil
    end
  end
end
