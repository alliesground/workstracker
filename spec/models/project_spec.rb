require 'rails_helper'

describe Project do
  it { should have_many(:memberships) }
  it { should have_many(:members).through(:memberships) }
end
