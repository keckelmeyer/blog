class Resource < ActiveRecord::Base
  validates :title, presence: true
end
