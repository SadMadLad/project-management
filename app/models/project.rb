# frozen_string_literal: true

# Every user has one project
class Project < ApplicationRecord
  has_many :user_project_maps, dependent: :destroy
  has_many :users, through: :user_project_maps, dependent: :destroy
  has_many :tasks, dependent: :destroy

  before_validation :strip_title

  validates :title, presence: true

  private

  def strip_title
    self.title = title.strip unless title.nil?
  end
end
