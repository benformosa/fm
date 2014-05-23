# encoding: utf-8
require 'spec_helper'

describe "Cars", :type => :request do
  describe "GET /cars" do
    it 'formats rego' do
      create_car('Test Car', 'make', 'model', 'abc 123', 'state', '10')
      Car.where(:name => 'Test Car').last.rego.should eql('ABC·123')
    end
  end

  it 'prevents duplicate car names' do
    create_car('Test Car', 'make', 'model', 'rego', 'state', '10')
    create_car('Test Car', 'make', 'model', 'rego', 'state', '10')
    Car.where(:name => 'Test Car').length.should eql(1)
  end
end
