# frozen_string_literal: true

# Controller for managing projects
class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  end

  def new
    if current_user.project.present?
      redirect_to project_path(current_user.project), notice: 'You already have a project'
    else
      @project = Project.new
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:user_id, :title)
  end
end
