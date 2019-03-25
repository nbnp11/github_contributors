require 'zip'

class CreateZip
  attr_accessor :repo_id

  def initialize(repo_id)
    @repo_id = repo_id
  end

  def call
    @contributors_url = 'https://ghcontribs.herokuapp.com/contributors'
    @repo = Repo.find(@repo_id)
    @archive_file = "#{Rails.root}/tmp/archive_#{DateTime.now.strftime("%B_%d_%Y_%k.%M")}.zip"
    Zip::OutputStream.open(@archive_file) do |zos|
      @repo.contributors.each do |contributor|
        @filename = "#{contributor.id}.pdf"
        @url = "#{@contributors_url}/#{@filename}"
        zos.put_next_entry(@filename)
        zos.print(URI.parse(@url).read)
      end
    end
    @archive_file
  end
end