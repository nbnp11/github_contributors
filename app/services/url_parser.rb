class UrlParser
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    binding.pry
    return unless valid_url?
    params = @url.remove('https://github.com/').split('/')
  end

  private

  def valid_url?
    binding.pry
    @testing = @url.remove('https://').split('/')
    return false unless @testing.count == 3 # проверяем, что у нас путь только до репозитория
    return false unless @testing.first.match?(/github.com/) # проверяем что домен верный
    true
  end
end