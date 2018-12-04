require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should have_one(:membership_role) }
end
