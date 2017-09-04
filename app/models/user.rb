class User < ApplicationRecord
  rolify
  after_create :assign_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role=(role)
    @role = role
  end

  def role
    @role
  end

  private

  def assign_role
    self.add_role role
  end
end
