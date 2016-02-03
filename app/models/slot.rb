class Slot < ActiveRecord::Base
  attr_accessor :data_hash
  
  before_save :process_data_hash
  
  belongs_to :training
  has_many :series, class_name: "Serie", dependent: :destroy
  
  private
  
  def process_data_hash
    if data_hash
      series_collection = []
      data_hash.each do |s|
        if s['id'].to_i > 0
          serie = Serie.find(s['id'].to_i)
        else
          serie = Serie.new()
        end
        serie.order = s['order'].to_i
        serie.excercise = Excercise.find(s['excercise'].to_i)
        serie.series = s['series'].to_i unless s['series'].empty?
        serie.note = s['note']
        serie.save
        series_collection << serie
      end
      self.series = series_collection
      Serie.where(slot: nil).destroy_all
    end
  end
end
