ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Use factories
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
  def login_owner(owner)
    post login_url, params: {
      session: { email: owner.email, password: '123456' }
    }
  end
end
