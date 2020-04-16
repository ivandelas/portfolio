require 'faker'

FactoryBot.define do
  factory :owner do
    transient do
      valid { true }
    end

    name { valid ? 'John Doe' : '' }
    email { valid ? 'john.doe@example.org' : 'john.doe#hey' }
    github { valid ? 'github.com/john-doe' : 'google-net_great 32' }
    linkedin { valid ? 'www.linkedin.com/in/john-doe' : 'nice_thing#23@ex' }
    about { valid ? Faker::Lorem.paragraph_by_chars(number: 100) : ('a' * 99) }
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
