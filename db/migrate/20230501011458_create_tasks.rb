class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :priority, null: false, default: 0
      t.decimal :latitude, null: false, default: 31.339291932
      t.decimal :longitude, null: false, default: 73.383910204

      t.timestamps
    end
  end
end
