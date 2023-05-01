# frozen_string_literal: true

# Controller for managing projects
class ProjectsController < ApplicationController
  layout 'authenticated'

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
  end

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
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully removed.'
    else
      redirect_to projects_path, notice: 'Could not remove the project'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
