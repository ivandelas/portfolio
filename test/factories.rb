# project factory
FactoryBot.define do
  sequence(:title) { |n| "project title #{n}" }
  sequence(:site) { |n| "https://site-url-#{n}.herokuapp.com" }
  sequence(:repo) { |n| "https://github.com/user/repo#{n}" }
  sequence(:img) { |n| "image#{n}.jpg" }

  factory :project do
    title { generate(:title) }
    description { 'some random description here just to test' }
    site { generate(:site) }
    repo { generate(:repo) }
    img { generate(:img) }
  end
end
