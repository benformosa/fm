require 'test_helper'

class DriverTest < ActiveSupport::TestCase
  test "should have name" do
    driver = Driver.new(:login => "jdoe")
    assert !driver.save, "Driver saved without name"
  end

  test "should have a login" do
    driver = Driver.new(:name => "John Doe")
    assert !driver.save, "Driver saved without login"
  end

  test "should have a unique login" do
    driver1 = Driver.create(:name => "John Doe", :login => "jdoe")
    driver2 = Driver.new(:name => "Jane Doe", :login => "jdoe")
    assert !driver2.save, "Driver saved with repeated login"
  end

  test "admin should exist" do
    assert Driver.where(login: "admin").count == 1, "Driver 'admin' not created"
  end

  test "unregistered should exist" do
    assert Driver.where(login: "unregistered").count == 1, "Driver 'unregistered' not created"
  end
end
