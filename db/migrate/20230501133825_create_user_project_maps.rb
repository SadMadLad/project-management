class CreateUserProjectMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :user_project_maps do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :project, null: false, foreign_key: true

      t.index [:user_id, :project_id], unique: true
      t.timestamps
    end
  end
end
