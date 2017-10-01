class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if current_person != nil
      @message.person = current_person
    else
  end

  private
    def message_params
      params.require(:message).permit(:message)
    end
end
