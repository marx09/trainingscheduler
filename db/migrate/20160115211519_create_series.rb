class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.text :note
      t.integer :order
      t.integer :series
      t.belongs_to :slot, index: true
      t.belongs_to :excercise, index: true
      
      t.timestamps null: false
    end
  end
end
