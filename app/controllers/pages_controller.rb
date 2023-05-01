# frozen_string_literal: true

# Controller for general Pages
class PagesController < ApplicationController
  def project
    @project = current_user.project
  end
end
