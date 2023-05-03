# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show destroy]

  layout 'authenticated'

  def index
    @tasks = current_user.tasks
  end

  def show; end

  def new
    @task = Task.new(project_id: params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      assigned_user_joins_project
      @tasks = @task.project.tasks
      respond_to do |format|
        format.html { redirect_to @project.task }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
    @tasks = @task.project.tasks
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
