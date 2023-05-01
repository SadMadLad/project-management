# frozen_string_literal: true

class UserProjectMap < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }
end
