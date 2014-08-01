require 'test_helper'

class EditingTasksTest < ActionDispatch::IntegrationTest

	setup do 
		host! 'api.lines.com'
		@line = Line.create!(name: "First line")
		@task = Task.create!(title: "First task", description: "task desc", line_id: @line.id )
	end

	test "edits task" do
		patch "/tasks/#{ @task.id }",
			{ title: "new title", description: "new description" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 200, response.status

		@task.reload
		assert_equal "new title", @task.title
		assert_equal "task desc", @task.description
	end

	test "doesnt allow empty title" do
		patch "/tasks/#{ @task.id }",
			{ title: "", description: "new description" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 422, response.status
	end

end
