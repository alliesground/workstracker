class Stakeholder
  delegate :email, :to => :user

  attr_reader :user
  def initialize(user:, resource:)
    @resource = resource
  end

  def self.all(resource: resource)
    owner = resource.user
    users = users_accepting_invitation_for(resource).inject([] << owner) do |stakeholders, user|
      users << user
    end

    stakeholders = users.map{ |user| new(user: user, resource: resource) }
  end

  private

  def self.users_accepting_invitation_for(resource)
    User.joins("INNER JOIN invitations ON invitations.recipient_email = users.email").merge(Invitation.accepted(scope: resource))
  end
end

project.stakeholders
def stakeholders(resource:)
  Stakeholder.all(resource: resource)
end
def self.all(resource:)
  where(resource_id: resource.id)
end

delegate :email, :to => :user
