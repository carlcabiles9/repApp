class User < ApplicationRecord
  # rolify
  has_many :project_users, class_name: "ProjectUser", dependent: :destroy
  has_many :projects, through: :project_users
  has_many :reports
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
end

