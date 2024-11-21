class CreateSessionMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :session_messages do |t|
      t.integer :user_id
      t.text :content
      t.datetime :time
      t.integer :session_id

      t.timestamps
    end
  end
end
