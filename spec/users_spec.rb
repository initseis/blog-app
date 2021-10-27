require 'rails_helper'

RSpec.describe 'Status Requests', type: :request do
  describe 'GET /users' do
    it 'returns a correct action' do
      get('/users')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is the list of users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns a correct action' do
      get('/users/123')
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Here is a user profile')
    end
  end
end
