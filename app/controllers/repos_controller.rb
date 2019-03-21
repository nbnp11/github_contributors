class ReposController < ApplicationController
  def show
    @repo = Repo.find(params[:id])
  end

  def download_zip
    @repo = Repo.find(params[:id])
    @archive_path = CreateZip.new(@repo.id).call
    #binding.pry
    send_file(@archive_path,
                   filename: "certificate_#{@repo.repo_name}.zip",
                       type: 'application/zip',
                disposition: 'attachment')
    #redirect_to repo_path(@repo)
  end
end
