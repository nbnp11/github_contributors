require 'zip'
require 'open-uri'

class CreateZip
  attr_accessor :repo_id, :base_url

  def initialize(repo_id, base_url)
    @repo_id = repo_id
    @base_url = base_url
  end

  def call
    @contributors_url = "#{base_url}/contributors"
    @repo = Repo.find(@repo_id)
    #binding.pry
    @archive_file = "#{Rails.root}/tmp/archive_#{DateTime.now.strftime("%B_%d_%Y_%k.%M")}.zip"
    Zip::OutputStream.open(@archive_file) do |zos|
      @repo.contributors.each do |contributor|
        #binding.pry
        @filename = "#{contributor.id}.pdf"
        @url = "#{@contributors_url}/#{@filename}"
        zos.put_next_entry(@filename)
        #zos.print(URI.parse(@url).read)
        get_pdf_thread = Thread.new { @file = open(@url).read }
        get_pdf_thread.join
        zos.print(@file)
        puts 'file added'
      end
    end
    @archive_file
  end
end