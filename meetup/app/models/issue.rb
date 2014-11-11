class Issue < ActiveRecord::Base
  has_many :comments
end
