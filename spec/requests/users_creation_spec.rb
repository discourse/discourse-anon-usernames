# frozen_string_literal: true
RSpec.describe "Users Creation" do
  before { SiteSetting.discourse_anon_usernames_enabled = true }

  describe "InvitesController#perform_accept_invitation" do
    context "with an email invite" do
      let(:topic) { Fabricate(:topic) }
      let(:invite) { Invite.generate(topic.user, email: "foo@discourse.org", topic: topic) }

      it "does not allow leaking last names in usernames" do
        put "/invites/show/#{invite.invite_key}.json",
            params: {
              username: "John_smith",
              name: "John Smith",
              password: "someverystringpassword",
            }

        expect(response.status).to eq(412)
        expect(response.body).to include(I18n.t("discourse_anon_usernames.errors.username_invalid"))
      end
    end
  end
end
