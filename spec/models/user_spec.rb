require 'spec_helper'

describe User, :type => :model do
  it "has default users" do
    expect(User.where(login: 'admin'))
    expect(User.where(login: 'unregistered'))
  end

  #it "reads attributes from AD" do
  #end
end
