class UrlParser
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    params = @url.remove('https://github.com/').split('/')
  end
end