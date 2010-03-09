

module Authorization
  class Engine
    def roles_for (user)
      [:admin]
    end
  end
end

Role.find_or_create_by_name(:name => "admin")
Role.find_or_create_by_name(:name => "user")

