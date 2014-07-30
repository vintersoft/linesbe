require 'test_helper'

class ListingLinesTest < ActionDispatch::IntegrationTest

	setup { host! 'api.lines.com' }

	test 'returns list of all lines' do
		line = Line.create!(name: "First line")

		get '/lines'
		assert_equal 200, response.status
		json = JSON.parse(response.body, symbolize_names: true)

		assert_equal "First line", json[:lines][0][:name]
	end

end
