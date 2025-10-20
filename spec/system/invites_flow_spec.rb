# frozen_string_literal: true

RSpec.describe "User invite flow" do
  before do
    SiteSetting.discourse_anon_usernames_enabled = true

    SiteSetting.full_name_requirement = "required_at_signup"
  end
  let(:topic) { Fabricate(:topic) }
  let(:invite) { Invite.generate(topic.user, email: "john@discourse.org", topic: topic) }
  let(:invite_form) { PageObjects::Pages::DiscourseAnonUsernames::InviteFormPage.new }
  describe "invite acceptance" do
    it "does not let user leak last names in usernames" do
      invite_form.open(invite.invite_key)

      invite_form.fill_name("John Smith")
      invite_form.fill_username("John_smith")
      invite_form.fill_password("someverystringpassword")

      invite_form.accept!

      expect(page).to have_content(I18n.t("discourse_anon_usernames.errors.username_invalid"))
    end

    describe "with `only_generated_usernames` setting enabled" do
      before { SiteSetting.only_generated_usernames = true }

      it "forces users to use generated usernames" do
        invite_form.open(invite.invite_key)

        expect(invite_form).to have_username_disabled
        expect(invite_form.username_field.value).to eq("")

        # generated usernames follow the pattern:
        # <first_name><random_word><number>

        invite_form.fill_name("John Smith")
        invite_form.randomize_username!

        generated_username = invite_form.username_field.value
        expect(generated_username).to include("John")

        random_words = SiteSetting.random_words_list.split("|")
        contains_random_word = random_words.any? { |word| generated_username.include?(word) }
        expect(contains_random_word).to eq(true)

        invite_form.fill_password("someverystringpassword")
        invite_form.accept!

        expect(page).to have_css(".login-welcome-header")
      end
    end
  end
end
