class SearchesController < ApplicationController
  def home
    @message = params[:message]
  end

  def search
    @url = params[:search][:url]
    @parsed_url = UrlParser.new(@url).call
    if @parsed_url.nil?
      @message = 'Error, invalid link'
      redirect_to root_path(message: @message)
    else
      @repo_params = { user_name: @parsed_url.first, repo_name: @parsed_url.last }
      @repo = Repo.find_or_create_by!(@repo_params)
      @response = Client.new(@repo.user_name, @repo.repo_name).get_contributors.take(3)
      @message = check_response(@response)
      if @message.match?(/Success/)
        @contributors = @response
        @contributors.each.with_index(1) do |contributor, place|
          @contributor_params = {
            login:          contributor['login'],
            contributions: contributor['contributions'].to_i,
            place:         place
          }
          @contributor = @repo.contributors.find_or_create_by(@contributor_params)
        end
      else
        @contributors = []
      end
      redirect_to repo_path(@repo, message: @message)
    end
  end

  private

  def check_response(response)
    if response.first.first.is_a? Array
      message = 'Success'
    else
      message = 'Error, repository not found'
    end
  end
end
