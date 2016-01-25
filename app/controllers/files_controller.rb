class FilesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create
    project = Project.find params[:project_id]

    if params[:image].present?
      data=params[:image]

      if data.original_filename.match(/\.png|\.jpg|\.eps/)
        File.open("public/vtex_data/#{current_user.number}/#{project.id}/images/#{data.original_filename}", 'wb') do |f|
          f.write(data.read)
        end

        html = "<tr id=\"#{data.original_filename.gsub(/\./, '_')}\"><td><a class=\"btn btn-link\" href=\"/vtex_data/#{current_user.number}/#{project.id}/images/#{data.original_filename}\">#{data.original_filename}</a></td><td class=\"pull-right\"><a data-confirm=\"削除しますか?\" class=\"btn btn-danger\" data-remote=\"true\" rel=\"nofollow\" data-method=\"delete\" href=\"/projects/#{project.id}/files?file=#{data.original_filename}\">削除</a></td></tr>"

        status = 'success'
        data = { html: html, tag_id: data.original_filename.gsub(/\./, '_') }
      else
        status = 'error'
        data = { message: '使用できる画像形式は[.png .jpg .eps]です' }
      end
    else
      unless File.exist?("#{Rails.root}/public/vtex_data/#{current_user.number}/#{project.id}/#{params[:file]}")
        content = "\\chapter{#{params[:file]}}\\label{#{params[:file]}}"
        File.write("#{Rails.root}/public/vtex_data/#{current_user.number}/#{project.id}/#{params[:file]}", content)

        html = "<tr id=\"#{params[:file].gsub(/\./, '_')}\"><td><a class=\"btn btn-link\" href=\"/projects/#{project.id}?file=#{params[:file]}\">#{params[:file]}</a></td><td class=\"pull-right\"><a data-confirm=\"削除しますか?\" class=\"btn btn-danger\" data-remote=\"true\" rel=\"nofollow\" data-method=\"delete\" href=\"/projects/#{project.id}/files?file=#{params[:file]}\">削除</a></td></tr>"

        status = 'success'
        data = { html: html, tag_id: params[:file].gsub(/\./, '_') }
      else
        status = 'error'
        data = { message: '同じ名前のファイルが存在します' }
      end
    end

    respond_to do |format|
      format.html { redirect_to project_path(project, file: params[:file]) }
      format.js { render json: { status: status, data: data } }
    end
  end

  def update
    project = Project.find params[:project_id]
    File.write("#{Rails.root}/public/vtex_data/#{current_user.number}/#{project.id}/#{params[:file]}", params[:content])
    respond_to do |format|
      format.html { redirect_to project_path(project, file: params[:file]) }
      format.js { render json: { status: 'success', data: { file: params[:file].gsub(/\./, '_') } } }
      format.json { render status: 200, json: { } }
    end
  end

  def destroy
    project = Project.find params[:project_id]

    if params[:file].include?(".tex")
      system("rm #{Rails.root}/public/vtex_data/#{current_user.number}/#{project.id}/#{params[:file]}")
    else
      system("rm #{Rails.root}/public/vtex_data/#{current_user.number}/#{project.id}/images/#{params[:file]}")
    end

    respond_to do |format|
      format.html { redirect_to project_path project }
      format.js { render json: { status: 'success', data: { method: 'delete', file: params[:file].gsub(/\./, '_') } } }
    end
  end
end
