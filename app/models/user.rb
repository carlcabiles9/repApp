# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  rolify strict: true, role_join_table_name: :user_roles, class_name: 'Role'
  has_one :profile, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :recipients
  #  has_many :user_roles, dependent: :destroy
  has_many :projects, through: :project_users, dependent: :destroy
  #  has_many :roles, through: :user_roles,  dependent: :destroy

  before_create :remember_value

  def valid_password?(password)
    if password.blank?
      true
    else
      super
    end
  end

  def password_required?
    new_record? ? false : super
  end

  def remember_value
    self.remember_token ||= Devise.friendly_token
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :rememberable, :validatable
end
