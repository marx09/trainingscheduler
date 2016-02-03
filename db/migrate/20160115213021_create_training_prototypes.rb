class CreateTrainingPrototypes < ActiveRecord::Migration
  def change
    create_table :training_prototypes do |t|
      t.integer :day
      t.time :from
      
      t.belongs_to :group, index: true
      t.timestamps null: false
    end
  end
end
