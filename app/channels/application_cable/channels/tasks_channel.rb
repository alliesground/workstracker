class TasksChannel < ApplicationCable::Channel
  def subscribed
    list = List.find(params[:list_id])
    stream_for list
  end
end
