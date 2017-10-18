class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if current_person != nil
      @message.person = current_person
      if @message.save
        redirect_back(@message.conversation)
      else
        redirect_to :roles
      end
    else
      redirect_to :projects
    end
  end

  private
    def message_params
      params.require(:message).permit(:message, :conversation_id)
    end

    def redirect_back(conversation)
      if conversation.interest
        redirect_to conversation.interest
      elsif conversation.task
        redirect_to conversation.task
      elsif conversation.project
        redirect_to conversation.project
      elsif conversation.role
        redirect_to conversation.role
      else
        redirect_to :roles
      end
    end
end
