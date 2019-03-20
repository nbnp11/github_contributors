class Client
  API_ENDPOINT = 'https://api.github.com/repos'.freeze

  attr_reader :user, :repo

  def initialize(user, repo)
    @user = user
    @repo = repo
  end

  def get_contributors
    request(
      http_method: :get,
      endpoint: "#{@user}/#{@repo}/contributors"
    )
  end

  private

  def client
    @_client ||= Faraday.new(API_ENDPOINT) do |client|
      client.request :url_encoded
      client.adapter Faraday.default_adapter
    end
  end

  def request(http_method:, endpoint:)
    response = client.public_send(http_method, endpoint)
    Oj.load(response.body)
  end
end
