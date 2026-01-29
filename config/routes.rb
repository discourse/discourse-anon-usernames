# frozen_string_literal: true

DiscourseAnonUsernames::Engine.routes.draw do
  # define routes here
end

Discourse::Application.routes.draw do
  mount ::DiscourseAnonUsernames::Engine, at: "discourse-anon-usernames"
end
