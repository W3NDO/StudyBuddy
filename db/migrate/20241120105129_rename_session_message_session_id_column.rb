class RenameSessionMessageSessionIdColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :session_messages, :session_id, :study_session_id
  end
end
