class User < ApplicationRecord
  attr_accessor :unhashed_password

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

  def remember_value
    self.remember_token ||= Devise.friendly_token
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :trackable,
   :recoverable, :rememberable, :validatable
searchable do
  text :name, boost: 5
  time :created_at
  end
end