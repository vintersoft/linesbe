module Api

	class TasksController < ApplicationController
	
		def index
			tasks = Task.where(line_id: params[:line_id])
			render json: tasks, status: 200
		end
	
	end

end