ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Users" do
          table_for User.order('id desc').limit(20) do
            column("Initiation date")    { |user| link_to(user.created_at, admin_user_path(user)) }
            column("First name")    { |user| user.first_name }
            column("Last name")   { |user| user.last_name }
            column("Identity_proof")   { |user| image_tag(user.identity_proof.url(:thumb)) }
            column("Identity_verified?")   { |user| link_to(user.identity_verified || "nil", admin_user_path(user)) }
            column("Address")   { |user| user.address }
            column("Address_proof")   { |user| image_tag(user.address_proof.url(:thumb)) }
            column("Address_verified?")   { |user| link_to(user.address_verified || "nil", admin_user_path(user)) }
          end
        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
