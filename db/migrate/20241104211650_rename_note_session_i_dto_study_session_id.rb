class RenameNoteSessionIDtoStudySessionId < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :session_id, :study_session_id
  end
end
