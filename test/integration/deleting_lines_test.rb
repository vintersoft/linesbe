require 'test_helper'

class DeletingLinesTest < ActionDispatch::IntegrationTest

	setup do
		host! "api.lines.com"
		@line = Line.create!(name: "First line")
	end

	test "deletes line" do
		delete "/lines/#{@line.id}"
		
		assert_equal 204, response.status
		assert_not Line.exists?(id: @line.id), "didn't delete the record"
	end

	test "deletes related tasks when deleting line" do
		task_one = Task.create!(title: "tone", description: "desc", line_id: @line.id)

		delete "/lines/#{@line.id}"
		
		assert_equal 204, response.status
		assert_not Line.exists?(id: @line.id), "didn't delete the line"
		assert_not Task.exists?(id: task_one.id), "didn't delete the task associated"
	end

end
