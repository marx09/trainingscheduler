# Template
class Template < ActiveRecord::Base
  attr_accessor :data_hash

  before_save :process_data_hash

  has_many :slots, -> { order '"order" asc' }, as: :slotable

  validates :name, presence: true

  private

  def process_data_hash
    if data_hash && data_hash['slots']
      slots_collection = []
      data_hash['slots'].each do |s|
        if s['id'].to_i > 0
          slot = Slot.find(s['id'].to_i)
        else
          slot = Slot.new
        end
        slot.attributes = {
          data_hash: s['series'],
          note: s['note'],
          order: s['order'].to_i
        }
        slot.save
        slots_collection << slot
      end
      self.slots = slots_collection
      Slot.where(slotable: nil).destroy_all
    end
  end
end
