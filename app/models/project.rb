# frozen_string_literal: true

# Every user has one project
class Project < ApplicationRecord
  belongs_to :user

  before_validation :strip_title

  validates :title, presence: true

  private

  def strip_title
    self.title = title.strip unless title.nil?
  end
end
