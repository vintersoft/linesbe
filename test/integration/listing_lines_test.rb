require 'test_helper'

class ListingLinesTest < ActionDispatch::IntegrationTest

	setup { host! 'api.lines.com' }

	test 'returns list of all lines' do
		line = Line.create!(name: "First line")

		get '/lines'
		assert_equal 200, response.status

		json = json(response.body)
		assert_equal "First line", json[:lines][0][:name]
	end

	test 'returns associated tasks ids for all lines' do
		line = Line.create!(name: "First line")
		task = Task.create!(title: "Task one", description: "Description of task one", line_id: 1)

		get '/lines'
		assert_equal 200, response.status

		json = json(response.body)
		assert_equal json[:lines][0][:links][:tasks], api_line_tasks_path(line.id)
	end

end
