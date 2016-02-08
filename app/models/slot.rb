# Slot
class Slot < ActiveRecord::Base
  attr_accessor :data_hash

  before_save :process_data_hash

  belongs_to :slotable, polymorphic: true
  has_many :series, -> { order '"order" asc' }, class_name: 'Serie', dependent: :destroy

  private

  def process_data_hash
    if data_hash
      series_collection = []
      data_hash.each do |s|
        if s['id'].to_i > 0
          serie = Serie.find(s['id'].to_i)
        else
          serie = Serie.new
        end
        serie.attributes = {
          order: s['order'].to_i,
          excercise: Excercise.find(s['excercise'].to_i),
          series: s['series'].to_i,
          note: s['note']
        }
        serie.save
        series_collection << serie
      end
      self.series = series_collection
      Serie.where(slot: nil).destroy_all
    end
  end
end
