# frozen_string_literal: true

# name: discourse-anon-usernames
# about: TODO
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

after_initialize do
  # Code which should run after Rails has finished booting
end
