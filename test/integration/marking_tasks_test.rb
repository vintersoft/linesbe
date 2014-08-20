require 'test_helper'

class MarkingTasksTest < ActionDispatch::IntegrationTest

	setup do 
		host! 'api.lines.com'
		@line = Line.create!(name: "First line")
		@task = Task.create!(title: "First task", description: "task desc", line_id: @line.id )
	end

	test "marks task as done" do
		patch "/tasks/#{ @task.id }/done", "",
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 200, response.status

		@task.reload
		assert_equal true, @task.done
	end

end
