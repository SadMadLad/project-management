# frozen_string_literal: true

# Devise User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :strip_name

  validates :first_name, presence: true,
                         format:   { with: /\A[a-zA-Z]+\z/, message: 'only letters allowed' }
  validates :last_name, presence: true,
                        format:   { with: /\A[a-zA-Z]+\z/, message: 'only letters allowed' }

  private

  def full_name
    "#{first_name} #{last_name}"
  end

  def strip_name
    self.first_name = first_name.strip.humanize unless first_name.nil?
    self.last_name = last_name.strip.humanize unless last_name.nil?
  end
end
