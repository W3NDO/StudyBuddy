class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :content
      t.integer :session_id
      t.integer :user_id

      t.timestamps
    end
  end
end
