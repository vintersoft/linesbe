require 'test_helper'

class ListingTasksTest < ActionDispatch::IntegrationTest

	setup { host! 'api.lines.com' }

	test 'returns list of all tasks' do

		line = Line.create!(name: "First line")
		task_one = Task.create!(title: "Task one", description: "desc", line_id: line.id)
		
		get "/lines/#{ line.id }/tasks"
		assert_equal 200, response.status
		json = json(response.body)

		assert_equal "Task one", json[:tasks][0][:title]
	end

end
