class UserProfile
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def email
    user.email
  end

  def roles
    @roles ||= user.roles
  end
end
