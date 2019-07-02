module Invitable
  def has_member_with_email?(email)
    members.exists?(email: email)
  end
end
