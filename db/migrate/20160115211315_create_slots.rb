class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :order
      t.text :note
      t.references :slotable, polymorphic: true, index: true
      
      t.timestamps null: false
    end
  end
end
