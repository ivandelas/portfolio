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

  def test_description_must_be_at_least_50_characters_long
    project = build(:project, description: ('a' * 49))
    assert project.invalid?
  end

  def test_description_must_be_at_most_200_characters_long
    project = build(:project, description: ('a' * 201))
    assert project.invalid?
  end

  def test_site_must_be_a_url
    project = build(:project, site: 'hey there')
    assert project.invalid?
  end

  def test_repo_must_be_a_url
    project = build(:project, repo: 'hey, how is it going?')
    assert project.invalid?
  end

  def test_img_must_be_a_valid_image_file_name
    project = build(:project, img: 'everything_is_fine.exe')
    assert project.invalid?
  end

  def test_active_projects_scope_gets_active_projects
    project1 = create(:project)
    project1.toggle!(:active)
    project2 = create(:project)
    project2.toggle!(:active)
    active_projects = Project.where(active: true)
    assert_respond_to Project, :active_projects
    assert_equal active_projects, Project.active_projects
  end
end
