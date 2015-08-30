require 'rails_helper'

describe 'Trips', :type => :request do
  describe 'GET /trips' do
    it 'displays some trips' do
      create_car('Test Car', 'make', 'model', 'rego', 'state', 10)
      login('user1', 'user1')
      visit cars_path
      click_link 'Test Car'
      expect(page).to have_content '10'
    end

    it 'displays a message when there are no trips' do
      login('user1', 'user1')
      visit trips_path
      expect(page).to have_content 'No trips found'
    end
  end
end
