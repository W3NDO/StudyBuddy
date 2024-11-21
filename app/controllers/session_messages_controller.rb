class SessionMessagesController < ApplicationController
  def create
    message = SessionMessage.new(session_message_params)

    if message.save
      # update chat UI
    end
  end

  private

  def session_message_params
    params.require(:session_message).permit(:content, :user_id, :session_id)
  end
end
