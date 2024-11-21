class Note < ApplicationRecord
  has_rich_text :content
  belongs_to :study_session
  belongs_to :user
end
