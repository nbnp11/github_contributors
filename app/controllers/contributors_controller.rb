class ContributorsController < ApplicationController
  def show
    @contributor = Contributor.find(params[:id])
    respond_to do |format|
      format.pdf do
        render pdf: "Certificate_for_#{@contributor.login}",
                        template: 'contributors/show.pdf.haml'
                     #disposition: 'attachment'
      end
    end
  end
end