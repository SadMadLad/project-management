# frozen_string_literal: true

class Task < ApplicationRecord
  enum priority: { standard: 0, important: 1, urgent: 2 }

  belongs_to :project
  belongs_to :user
  has_rich_text :description

  before_validation :strip_title

  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  private

  def strip_title
    self.title = title.strip unless title.nil?
  end
end
