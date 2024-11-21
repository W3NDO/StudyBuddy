class StudySession < ApplicationRecord
  after_create :create_note

  belongs_to :user
  has_many :session_messages
  has_one :note
  has_and_belongs_to_many :topics

  def create_note
    Note.create(study_session: self, user: self.user)
  end
end
