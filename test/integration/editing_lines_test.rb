require 'test_helper'

class EditingLinesTest < ActionDispatch::IntegrationTest

	setup { host! 'api.lines.com' }

	test 'edits line' do
		line = Line.create!(name: "First line")

		patch "/lines/#{ line.id }",
			{ name: "edited line" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 200, response.status
		assert_equal "edited line", line.reload.name
	end

end
