require 'rails_helper'

RSpec.describe Repo, type: :model do
  context 'validation' do
    it 'wont be valid without repo_name' do
      repo = Repo.new()
      expect(repo.valid?).to be false
    end

    it 'wont be valid without user_name' do
      repo = Repo.new(repo_name: 'test')
      expect(repo.valid?).to be false
    end

    it 'will be valid with user_name and repo_name' do
      repo = Repo.new(repo_name: 'test', user_name: 'test')
      expect(repo.valid?).to be true
    end
  end
end
