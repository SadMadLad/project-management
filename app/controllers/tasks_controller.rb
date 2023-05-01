# frozen_string_literal: true

class TasksController < ApplicationController
  layout 'authenticated'

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

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
    @task = Task.find(params[:id])
    if @task.destroy
      flash.now[:notice] = 'Task deleted successfully'
    else
      flash.now[:alert] = 'Could not delete the task'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :user_id, :project_id, :priority)
  end

  def assigned_user_joins_project
    @user_community_map = UserProjectMap.new(user_project_map_params)
    @user_community_map.save if @user_community_map.valid?
  end

  def user_project_map_params
    params.require(:task).permit(:user_id, :project_id)
  end
end
