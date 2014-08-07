require 'test_helper'

class ShowingTasksTest < ActionDispatch::IntegrationTest

	setup do
		host! 'api.lines.com'
		@line = Line.create!(name: "First line")
		@task = Task.create!(title: "Task one", description: "desc", line_id: @line.id)
	end

	test 'returns task' do

		get "/tasks/#{ @task.id }"
		assert_equal 200, response.status
		json = json(response.body)

		assert_equal "Task one", json[:task][:title]
	end

end
