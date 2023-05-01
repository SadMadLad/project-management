# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show destroy]

  layout 'authenticated'

  def index
    @tasks = current_user.tasks
  end

  def show; end

  def new
    @project = Project.find(params[:id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:task][:project_id])
    @task = Task.new(task_params)
    if @task.save
      flash.now[:notice] = 'Task created successfully'
      assigned_user_joins_project
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      flash.now[:notice] = 'Task deleted successfully'
    else
      flash.now[:alert] = 'Could not delete the task'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :user_id, :project_id, :priority, :latitude,
                                 :longitude)
  end

  def assigned_user_joins_project
    @user_community_map = UserProjectMap.new(user_project_map_params)
    @user_community_map.save if @user_community_map.valid?
  end

  def user_project_map_params
    params.require(:task).permit(:user_id, :project_id)
  end
end
