class Tool < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user

  belongs_to :tool_category

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  self.per_page = 25;
end
