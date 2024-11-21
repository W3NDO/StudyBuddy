class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :session_messages
  has_many :study_sessions
  has_many :notes

  def has_previous_study_session?
    not self.study_sessions.empty?
  end

  def get_last_study_session
    return self.study_sessions.order(updated_at: :desc).first
  end

  def user_study_sessions
    return self.study_sessions
  end
end
