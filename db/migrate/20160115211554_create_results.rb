class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.date :date
      t.integer :reps
      t.decimal :weight
      t.integer :time
      t.belongs_to :serie, null: false, index: true
      t.belongs_to :user, null: false, index: true
      

      t.timestamps null: false
    end
  end
end
