require "test_helper"

class CreatingLinesTest < ActionDispatch::IntegrationTest

	setup { host! "api.lines.com" }

	test "creates line" do
		
		post "/lines",
			{ name: "new line" }.to_json,
			{ "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s }

		assert_equal 201, response.status
		
		json = json(response.body)
		assert_equal api_line_url(json[:line][:id]), response.location

		assert_equal "new line", Line.find(json[:line][:id]).name
	end

	test "doesnt allow empty name" do
		post "/lines",
			{ name: "" }.to_json,
			{ "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s }

		assert_equal 422, response.status
	end

end
