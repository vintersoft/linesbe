require 'test_helper'

class CreatingTasksTest < ActionDispatch::IntegrationTest

	setup do
		host! 'api.lines.com'
		@linex = Line.create!(id: 22, name: "linea cero")
		@line = Line.create!(id: 24, name: "linea uno")
	end

	test "creates task" do
		post "/lines/#{@line.id}/tasks",
			{ title: "new task", description: "new desc" }.to_json,
			{ "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s }

		assert_equal 201, response.status
		
		json = json(response.body)
		assert_equal api_task_url(json[:task][:id]), response.location
		createdTask = Task.find(json[:task][:id])
		assert_equal "new task", createdTask.title
		assert_equal "new desc", createdTask.description
		assert_equal @line.id, createdTask.line_id
	end

	test "doesnt allow empty title" do
		post "/lines/#{@line.id}/tasks",
			{ title: "", description: "new desc" }.to_json,
			{ "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s }

		assert_equal 422, response.status
	end

end
