# frozen_string_literal: true

RSpec.describe DiscourseAnonUsernames do
  before { SiteSetting.discourse_anon_usernames_enabled = true }

  describe "username validation" do
    it "does not allow leaking last names in usernames" do
      user = User.new(username: "Jane_doe", name: "Jane Doe", email: "jane.doe@example.com")
      expect(user.valid?).to be_falsey
      expect(user.errors[:username]).to include(
        I18n.t("discourse_anon_usernames.errors.username_invalid"),
      )
    end

    it "does not block valid usernames" do
      user =
        User.new(username: "CoolAlice123", name: "Alice Smith", email: "alice.smith@example.com")
      expect(user.valid?).to be_truthy
    end

    it "does not run on group name validation" do
      group = Group.new(name: "group", visibility_level: Group.visibility_levels[:public])
      expect(group.valid?).to be_truthy
    end
  end
end
