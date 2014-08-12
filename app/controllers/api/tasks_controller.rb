module Api

	class TasksController < ApplicationController
	
		def index
			tasks = Task.where(line_id: params[:line_id])
			render json: tasks, status: 200
		end

		def create
			line = Line.find(params[:line_id])
			task = line.tasks.build(task_params)

			if task.save
				render json: task, status: 201, location: api_task_url(task)
			else
				render json: task.errors, status: 422
			end
		end

		def show
			task = Task.find(params[:id])
			render json: task, status: 200
		end

		def update
			task = Task.find(params[:id])
			if task.update(task_params)
				render json: task, status: 200
			else
				render json: task.errors, status: 422
			end
		end

		def destroy
			begin
				Task.destroy(params[:id])
				head 204
			rescue ActiveRecord::RecordNotFound
				head 404
			end
		end

		private

			def task_params
				params.require(:task).permit(:title, :description)
			end
	
	end

end