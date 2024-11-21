# frozen_string_literal: true

class ChatReflex < ApplicationReflex
    def add_to_note
        session = StudySession.includes(:note, :session_messages).find(element.dataset["session-id"])
        last_message = session.session_messages[-1]
        puts "#{last_message.content}"

        morph :nothing
    end

    def SendMessage
        puts "send message reflex"
    end
end
