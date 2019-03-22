require 'rails_helper'

RSpec.describe Contributor, type: :model do
  context 'validation' do
    it 'wont validate without login' do
      contributor = Contributor.new()
      expect(contributor.valid?).to be false
    end

    it 'wont validate without repo' do
      contributor = Contributor.new(login: 'test')
      expect(contributor.valid?).to be false
    end

    it 'will be valid with repo and login' do
      repo = Repo.new(id: 1, user_name: 'test', repo_name: 'test')
      contributor = repo.contributors.new(login: 'test')
      expect(contributor.valid?).to be true
    end
  end
end
