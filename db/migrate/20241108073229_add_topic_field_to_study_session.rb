class AddTopicFieldToStudySession < ActiveRecord::Migration[7.0]
  def change
    add_column :study_sessions, :topic, :string
  end
end
