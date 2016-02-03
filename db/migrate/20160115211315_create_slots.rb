class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :order
      t.text :note
      t.belongs_to :training, index: true
      
      t.timestamps null: false
    end
  end
end
