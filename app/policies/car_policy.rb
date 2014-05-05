class CarPolicy
  attr_reader :user, :car

  def initialize(user, car)
    @user = user
    @car = car
  end

  def modify?
    user.is_admin
  end
end
