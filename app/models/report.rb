class Report < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :project, optional: false
  

end


