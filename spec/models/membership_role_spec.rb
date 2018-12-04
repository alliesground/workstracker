require 'rails_helper'

RSpec.describe MembershipRole, type: :model do
  it { should belong_to(:membership) }
end
