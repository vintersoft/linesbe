require 'test_helper'

class CreatingLinesTest < ActionDispatch::IntegrationTest

	setup { host! 'api.lines.com' }

	test 'creates line' do
		line = Line.create!(name: "First line")

		post '/lines', 
			{ name: "new line" }.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

		assert_equal 201, response.status
		
		json = json(response.body)
		assert_equal api_line_url(json[:line][:id]), response.location
	end

end
