class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user, :category, :payload


  def self.categories
    %w[Iq Message Epic]
  end
end
