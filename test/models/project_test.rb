require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def test_title_must_be_at_least_10_characters_long
    project = build(:project, title: ('a' * 9))
    assert project.invalid?
  end

  def test_title_must_be_at_most_100_characters_long
    project = build(:project, title: ('a' * 101))
    assert project.invalid?
  end

  def test_title_must_be_unique
    project1 = create(:project)
    project2 = build(:project, title: project1.title)
    assert project2.invalid?
  end
end
