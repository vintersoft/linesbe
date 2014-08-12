require 'test_helper'

class DeletingTasksTest < ActionDispatch::IntegrationTest

	setup do
		host! "api.lines.com"
		@line = Line.create!(name: "First line")
		@task = Task.create!(title: "First task", description: "desc", line_id: @line.id)
	end

	test "deletes task" do
		delete "/tasks/#{@task.id}"
		
		assert_equal 204, response.status
		assert_not Task.exists?(id: @task.id), "didn't delete the record"
	end

	test "returns 404 when resource not found" do
		delete "/tasks/505050"

		assert_equal 404, response.status
	end

end
