require 'rails_helper'

describe User do
  it { should have_many(:memberships) }
  it { should have_many(:projects).through(:memberships) }
end
