class User < ApplicationRecord
  rolify strict: true, role_join_table_name: :user_roles, class_name: "Role"
  has_one_attached :avatar
  has_many :project_users, dependent: :destroy
  has_many :reports, dependent: :destroy
  #  has_many :user_roles, dependent: :destroy
  has_many :projects, through: :project_users, dependent: :destroy
  #  has_many :roles, through: :user_roles,  dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :rememberable, :validatable
end

