module Api

	class TasksController < ApplicationController
	
		def index
			tasks = Task.where(line_id: params[:line_id])
			render json: tasks, status: 200
		end

		def create
			line = Line.find_by(params[:line_id])
			task = line.tasks.build(task_params)

			if task.save
				render json: task, status: 201, location: api_line_task_url(line, task)
			else
				render json: task.errors, status: 422
			end
		end

		private

			def task_params
				params.require(:task).permit(:title, :desc)
			end
	
	end

end