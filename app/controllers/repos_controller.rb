class ReposController < ApplicationController
  def show
    @repo = Repo.find(params[:id])
    #@message = params[:message]
  end

  def download_zip
    #binding.pry
    @repo = Repo.find(params[:id])
    @archive_path = CreateZip.new(@repo.id, request.base_url).call
    #@message = 'Success'
    #binding.pry
    puts send_file(@archive_path)#,
                   #filename: "certificate_#{@repo.repo_name}.zip",
                       #type: 'application/zip',
                #disposition: 'attachment')
    #FileUtils.rm_f(@archive_path)
    redirect_to repo_path(@repo)#, message: @message)
  end
end
