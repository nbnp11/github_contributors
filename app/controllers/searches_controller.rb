class SearchesController < ApplicationController
  def home; end

  def search
    @url = params[:search][:url]
    @parsed_url = UrlParser.new(@url).call
    @repo_params = { user_name: @parsed_url.first, repo_name: @parsed_url.last }
    @repo = Repo.find_or_create_by!(@repo_params)

    @contributors = Client.new(@repo.user_name, @repo.repo_name).get_contributors.take(3)
    @contributors.each.with_index(1) do |contributor, place|
      @contributor_params = {
        login:          contributor['login'],
        contributions: contributor['contributions'].to_i,
        place:         place
      }
      @contributor = @repo.contributors.find_or_create_by(@contributor_params)
    end
    redirect_to repo_path(@repo)
  end
end
