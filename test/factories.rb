require 'faker'

FactoryBot.define do
  factory :owner do
    transient do
      valid { true }
    end

    name { valid ? 'John Doe' : '' }
    email { valid ? 'john.doe@example.org' : 'john.doe#hey' }

    github do
      if valid
        'https://github.com/santiago-rodrig'
      else
        'google-net_great 32'
      end
    end

    linkedin do
      if valid
        'https://www.linkedin.com/in/santiago-andres-rodriguez-marquez'
      else 'nice_thing#23@ex' end
    end

    about { valid ? Faker::Lorem.paragraph_by_chars(number: 100) : ('a' * 99) }

    location do
      if valid
        'Caracas, Capital District, Venezuela'
      else
        'My house next to the gas station grooves street come now!'
      end
    end

    after(:create, :build) do |owner|
      owner.profile_image.attach(
        io: File.open(Rails.root.join(
          'app', 'assets', 'images', 'profile.png')),

        filename: 'profile.png',
        content_type: 'image/png'
      )
    end
  end

  sequence(:title) { |n| "project title #{n}" }
  sequence(:site) { |n| "https://site-url-#{n}.herokuapp.com" }
  sequence(:repo) { |n| "https://github.com/user/repo#{n}" }

  factory :project do
    transient do
      attach_image { true }
    end

    title { generate(:title) }
    description { 'spam' * 13 }
    site { generate(:site) }
    repo { generate(:repo) }

    after(:build, :create) do |project, evaluator|
      if evaluator.attach_image
        project.demo_image.attach(
          io: File.open('app/assets/images/placeholder.jpg'),
          filename: 'placeholder.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
