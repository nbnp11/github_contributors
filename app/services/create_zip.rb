require 'zip'

class CreateZip
  attr_accessor :repo_id

  def initialize(repo_id)
    @repo_id = repo_id
  end

  def call
    @contributors_url = 'https://ghcontribs.herokuapp.com/contributors'
    @repo = Repo.find(@repo_id)
    @archive_file = "#{Rails.root}/tmp/archive_#{DateTime.now.strftime("%B_%d_%Y_%k.%m")}.zip"
    Zip::OutputStream.open(@archive_file) do |zos|
      @repo.contributors.each do |contributor|
        #binding.pry
        @filename = "#{contributor.id}.pdf"
        @url = "#{@contributors_url}/#{@filename}"
        zos.put_next_entry(@filename) # Give it next file a filename
        zos.print(URI.parse(@url).read)
        #@file = GetPdfForContributorJob.perform_now(contributor.id)
        #zos.print(@file) unless $pdf_job_is_running
        #request_thread = Thread.new { zos.print(URI.parse(@url).read) } # Add file to zip
        #request_thread.join
      end
    end
    @archive_file
  end
end