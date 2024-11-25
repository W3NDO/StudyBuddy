class StudySessionController < ApplicationController
  before_action :authenticate_user!

  def index
    @sessions = current_user.user_study_sessions.order(updated_at: :desc)
  end

  def show
    @session = StudySession.includes(:note, :session_messages).find(params[:id])
    @note = @session.note
    @messages = @session.session_messages
    @ai = User.find_by(handle: "SB1")
  end

  def new
    @study_session = StudySession.new
  end

  def edit
  end

  def create
    @study_session = StudySession.new(study_session_params)
    @study_session.user = current_user
    if @study_session.save
      redirect_to @study_session, notice: "Study session created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def study_session_params
    params.require(:study_session).permit(:session_name, :session_description, :topic)
  end
end
