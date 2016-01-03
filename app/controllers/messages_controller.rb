class MessagesController < ApplicationController
  def view
    @message = Message.find(params[:id])
    if @message.update(viewed: true)
      render json: "{'status': 'success'}"
    else
      render json: "{'status': 'failure'}"
    end
  end
end
