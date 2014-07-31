module Api

	class LinesController < ApplicationController

		def index
			lines = Line.all
			render json: lines, status: 200
		end

		def create
			line = Line.new(line_params)
			if line.save
				render json: line, status: 201, location: api_line_url(line)
			else
				render json: line.errors, status: 422
			end
		end

		def update
			line = Line.find(params[:id])
			if line.update(line_params)
				render json: line, status: 200
			else
				render json: line.errors, status: 422
			end
		end

		private

			def line_params
				params.require(:line).permit(:name)
			end

	end

end
