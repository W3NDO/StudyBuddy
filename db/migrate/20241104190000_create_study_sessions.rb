class CreateStudySessions < ActiveRecord::Migration[7.0]
  def change
    create_table :study_sessions do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :session_name
      t.text :session_description

      t.timestamps
    end
  end
end
