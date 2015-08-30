# encoding: utf-8
require 'rails_helper'

describe "Cars", :type => :request do
  describe 'GET /cars' do
    it 'displays some cars' do
      create_car('Test Car', 'make', 'model', 'rego', 'state', 10)
      login('user1', 'user1')
      visit cars_path
      expect(page).to have_content 'Test Car'
    end
  end
end
