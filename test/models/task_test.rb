require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  test "newly created task is not DONE" do
  	task = Task.create!(title: "Title")
    assert task[:done] == false
  end

end
