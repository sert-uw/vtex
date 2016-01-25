class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
    open_file @project.id
    get_pdf_file @project.id
    get_err_file @project.id
    get_sty_files @project.id
    get_tex_files @project.id
    get_image_files @project.id
  end

  def new
    @project = current_user.projects.build
  end

  def edit
  end

  def create
    project = current_user.projects.build project_params

    if project.save
      init_directory project.id, params[:template]
      redirect_to project_path(project)
    else
      redirect_to :new
    end
  end

  def update
    if @project.update project_params
      redirect_to :show, project_path(project)
    else
      redirect_to :edit
    end
  end

  def destroy
    @project.delete
    redirect_to projects_path
  end

  private

  def set_project
    @project = current_user.projects.find params[:id]
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def init_directory id, template
    p system("mkdir #{Rails.root}/public/vtex_data/#{current_user.number}/#{id}")
    p system("cp -r #{Rails.root}/public/vtex_data/#{template}/* #{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/")
  end

  def get_pdf_file id
    unless File.exist?("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/document.pdf")
      @pdf_file = nil
      return
    end

    files = Dir.glob "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/document.pdf"
    f_name = File.basename(files.first)
    @pdf_file = { name: f_name, path: "/vtex_data/#{current_user.number}/#{id}/#{f_name}" }
  end

  def get_err_file id
    unless File.exist?("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/errors/error.err")
      @err_file = nil
      return
    end

    files = Dir.glob "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/errors/error.err"
    f_name = File.basename(files.first)
    @err_file = { name: f_name, path: "/vtex_data/#{current_user.number}/#{id}/errors/#{f_name}" }
  end

  def get_sty_files id
    files = Dir.glob "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/*.sty"

    @sty_files = []
    files.each do |f|
      f_name = File.basename(f)
      @sty_files << { name: f_name, path: "/vtex_data/#{current_user.number}/#{id}/#{f_name}" }
    end
  end

  def get_tex_files id
    files = Dir.glob "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/*.tex"

    @tex_files = []
    files.each do |f|
      f_name = File.basename(f)
      @tex_files << { name: f_name, path: "/vtex_data/#{current_user.number}/#{id}/#{f_name}" }
    end
  end

  def get_image_files id
    png = "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/images/*.png"
    jpg = "#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/images/*.jpg"
    files = Dir.glob [png, jpg]

    @image_files = []
    files.each do |f|
      f_name = File.basename(f)
      @image_files << { name: f_name, path: "/vtex_data/#{current_user.number}/#{id}/images/#{f_name}" }
    end
  end

  def open_file id
    if params[:file].present?
      f_name = params[:file]
    else
      f_name = 'document.tex'
    end

    if f_name == 'document.tex'
      unless File.exist?("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/document.tex")
        File.write("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/document.tex", "document")
      end
    end

    if f_name == 'error.err'
      f = Pathname("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/errors/error.err").expand_path.read(encoding: Encoding::UTF_8)
    else
      f = Pathname("#{Rails.root}/public/vtex_data/#{current_user.number}/#{id}/#{f_name}").expand_path.read(encoding: Encoding::UTF_8)
    end

    @open_file = { name: f_name, content: f }
  end
end
