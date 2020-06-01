class ProjectUser < ApplicationRecord
    belongs_to :user, class_name: "User", :optional => true
    belongs_to :project, :optional => true
end