class Report < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :project, optional: false
  
  # def week
  #   created_at.strftime('%W')
  # end 
end


