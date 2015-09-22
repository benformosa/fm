# encoding: utf-8

class Car < ActiveRecord::Base
  belongs_to :user
  has_many :trips
  has_many :users, through: :trips
  
  validates :name, presence: true, uniqueness: true
  validates :make, presence: true
  validates :model, presence: true
  validates :rego, presence: true
  validates :state, presence: true
  validates :start_odo, presence: true, numericality: true
  validates :initial_location, presence: true
    
  after_save :format_rego

  # replace spaces in rego with interpuncts, change to uppercase
  def format_rego
    unless self.rego.nil?
      self.update_column(:rego, self.rego.gsub(' ', '·').upcase)
    end
  end
end
