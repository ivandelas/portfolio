# project factory
FactoryBot.define do
  factory :user do
    
  end

  sequence(:title) { |n| "project title #{n}" }
  sequence(:site) { |n| "https://site-url-#{n}.herokuapp.com" }
  sequence(:repo) { |n| "https://github.com/user/repo#{n}" }
  sequence(:img) { |n| "image#{n}.jpg" }

  factory :project do
    title { generate(:title) }
    description { 'smap' * 13 }
    site { generate(:site) }
    repo { generate(:repo) }
  end
end
