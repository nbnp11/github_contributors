require 'rails_helper'

RSpec.describe ReposController, type: :controller do
  repo_id = Repo.first.id
  params = {}
  params[:id] = repo_id

  context 'test repos#show' do
    it 'will render show page with valid repo id' do
      get :show, params: params
      expect(response).to have_http_status(200)
    end
  end
end