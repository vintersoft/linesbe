require 'test_helper'

class EditingLinesTest < ActionDispatch::IntegrationTest

	setup do 
		host! 'api.lines.com'
		@line = Line.create!(name: "First line")
	end

	test 'edits line' do
		patch "/lines/#{ @line.id }",
			{ name: "edited line" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 200, response.status
		assert_equal "edited line", @line.reload.name
	end

	test "doesnt allow empty name" do
		patch "/lines/#{ @line.id }",
			{ name: "" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 422, response.status
	end

end
