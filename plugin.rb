# frozen_string_literal: true

# name: discourse-anon-usernames
# about: Generate anonymous usernames for users and blocks them from using their real names in usernames
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_anon_usernames_enabled

module ::DiscourseAnonUsernames
  PLUGIN_NAME = "discourse-anon-usernames"
end

require_relative "lib/discourse_anon_usernames/engine"

register_asset "stylesheets/anon-usernames.scss"

after_initialize do
  on(:user_created) do |user|
    username = user.username
    last_name = user.name.split(" ").last

    is_leaking_last_name = username.downcase.include?(last_name.downcase)
    if is_leaking_last_name
      user.errors.add(:username, I18n.t("discourse_anon_usernames.errors.username_invalid"))
      raise ActiveRecord::RecordInvalid.new(user)
    end
  end
end
