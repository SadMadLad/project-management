# frozen_string_literal: true

# Controller for managing projects
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show destroy]

  layout 'authenticated'

  def index
    @projects = current_user.projects
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to root_path, notice: 'Project was created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully removed.'
    else
      redirect_to projects_path, notice: 'Could not remove the project'
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
