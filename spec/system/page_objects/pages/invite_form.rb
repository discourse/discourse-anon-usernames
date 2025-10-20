# frozen_string_literal: true

module PageObjects
  module Pages
    module DiscourseAnonUsernames
      class InviteFormPage < PageObjects::Pages::InviteForm
        def fill_name(full_name)
          find("#new-account-name").fill_in(with: full_name)
        end

        def accept!
          find(".invitation-cta__accept").click
        end

        def username_field
          find("#new-account-username")
        end

        def has_username_disabled?
          username_field[:disabled] == true
        end

        def randomize_username!
          find(".randomizer-btn").click
        end
      end
    end
  end
end
