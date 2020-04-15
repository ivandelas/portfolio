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

    after(:build, :create) do |user|
      user.demo_image.attach(
        io: File.open('app/assets/images/placeholder.jpg'),
        filename: 'placeholder.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
