require 'rails_helper'

RSpec.describe ContributorsController, type: :controller do
  contributor_id = Contributor.first.id
  params = {}

  context 'test contributors#show' do
    it 'will render pdf with valid contributor' do
      params[:id] = contributor_id
      get :show, params: params, format: :pdf
      expect(response.header['Content-Type']).to include 'application/pdf'
    end
  end
end