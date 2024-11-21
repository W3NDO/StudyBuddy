# app/controllers/queries_controller.rb
require_relative "../services/sambanova_service"
class QueriesController < ApplicationController
  before_action :initialize_sambanova
  include ActionController::Live

  def create
    query = params[:query]
    topic = params[:topic]
    session_id = params[:session_id]
    @ai = User.find_by(handle: "SB1")
    # messages = Session.find(params[:session_id])

    question = SessionMessage.new({
      user_id: current_user.id,
      content: query,
      study_session_id: session_id,
      time: Time.now
    })
    question.save if question.valid?

    @ai_message = SessionMessage.create!(content: "", user_id: User.find_by(handle: "SB1")&.id, study_session_id: session_id, time: Time.now )

    Turbo::StreamsChannel.broadcast_append_to "chat", target: "chat_messages", partial: "queries/session_messages", locals: {messages: [question, @ai_message], ai: @ai}

    @service ||= SambanovaService.new
    response_stream(query, topic, session_id)
  end

  private

  def response_stream(query, topic, session_id)
    response.headers["Content-Type"] = "text/event-stream"
    chunks = ""
        # Stream response
    @service.make_request(query, topic) do |chunk|
      # Broadcast each chunk to the Turbo Stream
      chunks += chunk
      Turbo::StreamsChannel.broadcast_append_to(
        "chat", # Matches the target in the view
        target: "ai_response_#{@ai_message.id}",
        partial: "queries/ai_response",
        locals: {chunk: chunk}
        )
      end
    @ai_message.content = chunks
    @ai_message.save
    head :ok # Signal successful processing
    
    ensure
      # Ensure the stream is closed properly
      response.stream.close
      
  end

  def initialize_sambanova
    @service = SambanovaService.new
  end
end
