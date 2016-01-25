
class PdfCreatesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_project, only: [:show]

  def show
    Dir.chdir("#{Rails.root}/public/vtex_data/#{current_user.number}/#{@project.id}/") do
      system("timeout -sKILL 10s sh create_pdf.sh")
      f = Pathname("#{Rails.root}/public/vtex_data/#{current_user.number}/#{@project.id}/errors/error.err").expand_path.read(encoding: Encoding::UTF_8)

      unless f.include?('! Emergency stop.')
        system("timeout -sKILL 10s sh create_pdf.sh")
        system("rm errors/error.err")

        respond_to do |format|
          format.html { redirect_to project_path(@project, file: params[:file]) }
          format.js { render json: { status: 'success', data: { path: "/vtex_data/#{current_user.number}/#{@project.id}/document.pdf" } } }
        end
      else
        respond_to do |format|
          format.html { redirect_to project_path(@project, file: 'error.err') }
          format.js { render json: { status: 'error', data: { path: "/projects/#{@project.id}/error_pages" } } }
        end
      end
    end
  end

  private

  def set_project
    @project = Project.find params[:project_id]
  end
end
