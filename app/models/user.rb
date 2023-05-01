# frozen_string_literal: true

# Devise User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :strip_name

  has_many :user_project_maps, dependent: :destroy
  has_many :projects, through: :user_project_maps, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :first_name, presence: true,
                         format:   { with: /\A[a-zA-Z]+\z/, message: 'only letters allowed' }
  validates :last_name, presence: true,
                        format:   { with: /\A[a-zA-Z]+\z/, message: 'only letters allowed' }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def strip_name
    self.first_name = first_name.strip.humanize unless first_name.nil?
    self.last_name = last_name.strip.humanize unless last_name.nil?
  end
end
