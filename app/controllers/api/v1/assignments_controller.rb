module Api
  module V1
    class AssignmentsController < ApiController
      def context
        if(params[:user_id].present? && params[:task_id].present?)
          {user_id: params[:user_id], task_id: params[:task_id]}
        end
      end
    end
  end
end
