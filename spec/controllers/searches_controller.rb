require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  context 'test searches#home' do
    it 'will return 200 for home page' do
      params = {}
      params[:message] = 'test'
      get :home, params: params
      expect(response).to have_http_status(200)
    end
  end
  context 'test searches#search' do
    params = {}
    params[:search] = {}
    it 'will redirect back with invalid url' do
      params[:search][:url] = 'invalid_url'
      post :search, params: params
      expect(response).to redirect_to 'http://test.host/?message=Error%2C+invalid+link'
    end
    it 'will redirect to repo page with valid url' do
      params[:search][:url] = 'https://github.com/rails/rails'
      post :search, params: params
      expect(response).to have_http_status(302)
      expect(response.body).to match(/Success/)
    end
  end
end