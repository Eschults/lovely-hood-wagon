require 'pundit'

# https://github.com/gregbell/active_admin/blob/master/lib/active_admin/authorization_adapter.rb
module ActiveAdmin
  # References
  #
  # Default Authorization permissions for Active Admin
  #
  # module Authorization
  #   READ    = :read
  #   CREATE  = :create
  #   UPDATE  = :update
  #   DESTROY = :destroy
  # end

  class PunditAdapter < AuthorizationAdapter
    def authorized?(action, subject = nil)
      action = if subject.is_a? Class
        :index?
      else
        override_action_name action
      end
      Pundit.policy(user, subject).public_send action
    end

    def scope_collection(collection, action = Auth::READ)
      Pundit.policy_scope(user, collection)
    end

    def override_action_name(action)
      case action
      # https://github.com/elabs/pundit/blob/master/lib/generators/pundit/install/templates/application_policy.rb
      when :read
        :show?
      when :create
        :create?
      when :update
        :update?
      when :destroy?
        :destroy?
      else
        "#{ action }?"
      end
    end
  end
end