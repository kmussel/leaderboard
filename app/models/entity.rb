class Entity < ActiveRecord::Base
  self.per_page = 10
  has_many :entries, :dependent => :destroy
  has_many :leaderboards, :through => :entries
  accepts_nested_attributes_for :entries
  
  
end