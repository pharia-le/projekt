class CreateTaskCircumstances < ActiveRecord::Migration[6.0]
  def change
    create_table :task_circumstances do |t|
      t.belongs_to :task, null: false, foreign_key: true
      t.belongs_to :circumstance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
