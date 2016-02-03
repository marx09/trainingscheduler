class CreateTrainingResults < ActiveRecord::Migration
  def change
    create_table :training_results do |t|
      t.integer :time
      t.integer :rate
      t.integer :calories
      
      t.belongs_to :training
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
