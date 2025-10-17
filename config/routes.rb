# frozen_string_literal: true

DiscourseAnonUsernames::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::DiscourseAnonUsernames::Engine, at: "discourse-anon-usernames" }
