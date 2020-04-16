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

    it 'must have two words' do
      invalid_owner.name = 'Jen'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :name
      invalid_owner.name = 'Jo Aj'
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
      _(valid_owner.github).must_equal 'https://github.com/santiago-rodrig'
      _(valid_owner).must_be :valid?
      _(invalid_owner.github).must_equal 'google-net_great 32'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :github
    end

    it 'must be a typical github profile' do
      invalid_owner.github = 'https://github.com/santiago-rodrig/facebug'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :github
    end
  end

  describe 'linkedin profile link' do
    it 'must be a standard valid url' do
      _(valid_owner.linkedin).must_equal(
        'https://www.linkedin.com/in/santiago-andres-rodriguez-marquez'
      )

      _(valid_owner).must_be :valid?
      _(invalid_owner.linkedin).must_equal 'nice_thing#23@ex'
      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :linkedin
    end

    it 'must be a typical linkedin profile' do
      invalid_owner.linkedin = 'https://www.linkedin.com/in/123123g__.rf'
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

  describe 'creating owners' do
    it 'must be only one owner' do
      Owner.all.each do |owner|
        owner.destroy
      end

      valid_owner.save
      _(Owner.count).must_equal 1
      owner = build(:owner, name: 'Jen Smith')
      owner.save
      _(Owner.count).must_equal 1
      _(owner).must_be :invalid?
      _(owner.errors[:base]).must_include 'Only one owner is allowed'
    end
  end

  describe 'location' do
    it 'must be a city followed by a state, followed by a country' do
      _(invalid_owner.location).must_equal(
        'My house next to the gas station grooves street come now!'
      )

      _(invalid_owner).must_be :invalid?
      _(invalid_owner.errors).must_include :location
    end
  end
end
