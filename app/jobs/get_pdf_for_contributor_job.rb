class GetPdfForContributorJob < ApplicationJob
  queue_as :default

  def perform(contributor_id)
    #binding.pry
    $pdf_job_is_running = true
    @url = "#{contributor_url}/#{contributor_id.to_s}"
    $pdf_job_is_running = false
    URI.parse(@url).read

  end

  private

  def contributor_url
    if Rails.env.development? || Rails.env.test?
      @url = "http://localhost:3000/contributors"
    elsif Rails.env.production?
      @url = "http://mydomain.com/contributors"
    end
    @url
  end
end
