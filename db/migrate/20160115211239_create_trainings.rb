class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.date :date
      t.time :from
      t.date :from_prototype_at
      t.belongs_to :training_prototype, null: true, index: true
      
      t.timestamps null: false
    end
  end
end
