class ErrorPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @open_file = Pathname("#{Rails.root}/public/vtex_data/#{current_user.number}/#{params[:project_id]}/errors/error.err").expand_path.read(encoding: Encoding::UTF_8)
  end
end
