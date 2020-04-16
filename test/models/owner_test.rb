require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  let(:invalid_owner) { build(:owner, valid: false) }
  let(:valid_owner) { build(:owner) }

  describe 'name' do
    it 'must be standard' do
      _(valid_owner.name).must_equal 'John Doe'
      _(valid_owner).must_be :valid?
    end

    it 'must be present' do
      _(invalid_owner.name).must_equal ''
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
    end

    it 'must have two words of at least 3 characters' do
      invalid_owner.name = 'Jen'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Jo Aj'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Joe Do'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Jo Doe'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
    end

    it 'must have each word capitalized' do
      invalid_owner.name = 'joe Doe'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Joe dOe'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Joe DOE'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'joe doe'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
    end
  end

  describe 'email' do
    it 'must be a standard valid email' do
      _(valid_owner.email).must_equal 'john.doe@example.org'
      _(valid_owner).must_be :valid?
      _(invalid_owner.email).must_equal 'john.doe#hey'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :email
    end
  end

  describe 'github profile link' do
    it 'must be a standard valid url' do
      _(valid_owner.github).must_equal 'https://github.com/john-doe'
      _(valid_owner).must_be :valid?
      _(invalid_owner.github).must_equal 'google-net_great 32'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :github
    end
  end

  describe 'linkedin profile link' do
    it 'must be a standard valid url' do
      _(valid_owner.linkedin).must_equal 'https://www.linkedin.com/in/john-doe'
      _(valid_owner).must_be :valid?
      _(invalid_owner.linkedin).must_equal 'nice_thing#23@ex'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :linkedin
    end
  end

  describe 'about text' do
    it 'must be of at least 100 characters long' do
      _(valid_owner.about.length).must_equal 100
      _(valid_owner).must_be :valid?
      _(invalid_owner.about.length).must_equal 99
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :about
    end
  end
end
