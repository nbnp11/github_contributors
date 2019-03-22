class ReposController < ApplicationController
  def show
    @repo = Repo.find(params[:id])
    @message = params[:message]
  end

  def download_zip
    @repo = Repo.find(params[:id])
    @archive_path = CreateZip.new(@repo.id).call
    send_file(@archive_path,
                   filename: "certificate_#{@repo.repo_name}.zip",
                       type: 'application/zip',
                disposition: 'attachment')
    redirect_to repo_path(@repo)
  end
end
