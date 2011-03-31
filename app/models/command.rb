class Command < ActiveRecord::Base
  attr_accessible :url, :user
  belongs_to :user
  validates_presence_of :user
end
