class Stakeholder
  delegate :email, :gravatar_url, :to => :user
  delegate :roles_scoped_to, :to => :user

  attr_reader :user
  def initialize(user:)
    @user = user
  end

  def self.all_scoped_to(resource:)
    users = User.joins(
      <<~SQL
        INNER JOIN users_roles
        ON users_roles.user_id = users.id
        INNER JOIN roles
        ON roles.id = users_roles.role_id
      SQL
    ).merge(Role.scoped_to(resource_id: resource.id))

    users.map {|user| new(user: user)}
  end
end
