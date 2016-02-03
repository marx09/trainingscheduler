class CreateExcercises < ActiveRecord::Migration
  def change
    create_table :excercises do |t|
      t.string :name
      t.text :description
      t.boolean :reverse_weight, default: false
      t.timestamps null: false
    end
  end
end
