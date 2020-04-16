require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @owner = create(:owner)
  end

  def test_title_must_be_at_least_10_characters_long
    project = @owner.projects.build(
      attributes_for(:project, title: ('a' * 9))
    )

    assert project.invalid?
  end

  def test_title_must_be_at_most_150_characters_long
    project = @owner.projects.build(
      attributes_for(:project, title: ('a' * 151))
    )

    assert project.invalid?
  end

  def test_title_must_be_unique
    project1 = @owner.projects.create(attributes_for(:project))

    project2 = @owner.projects.build(
      attributes_for(:project, title: project1.title)
    )

    assert project2.invalid?
  end

  def test_description_must_be_at_least_50_characters_long
    project = @owner.projects.build(
      attributes_for(:project, description: ('a' * 49))
    )

    assert project.invalid?
  end

  def test_description_must_be_at_most_300_characters_long
    project = @owner.projects.build(
      attributes_for(:project, description: ('a' * 301))
    )

    assert project.invalid?
  end

  def test_site_must_be_a_url
    project = @owner.projects.build(
      attributes_for(:project, site: 'hey there')
    )

    assert project.invalid?
  end

  def test_repo_must_be_a_url
    project = @owner.projects.build(
      attributes_for(:project, repo: 'hey, how is it going?')
    )

    assert project.invalid?
  end

  def test_repo_must_be_a_repository_url
    project = @owner.projects.build(
      attributes_for(
        :project, repo: 'https://github.com/mrnadaara.swift'
      )
    )

    assert project.invalid?
  end

  def test_repo_and_site_must_be_existing_uris
    project = @owner.projects.build(
      attributes_for(
        :project,
        repo: 'https://github.com/mrnadaara/stfu.swift',
        site: 'https://something-here-srodrig.herokuapp.com'
      )
    )

    assert project.invalid?

    project = @owner.projects.build(
      attributes_for(
        :project,
        repo: 'https://github.com/santiago-rodrig/facebug',
        site: 'https://facebug-srodrig.herokuapp.com'
      )
    )

    assert project.valid?
  end

  def test_active_projects_scope_gets_active_projects
    project1 = @owner.projects.create(
      attributes_for(:project)
    )

    project2 = @owner.projects.create(
      attributes_for(:project)
    )

    project1.toggle!(:active)
    project2.toggle!(:active)
    active_projects = Project.where(active: true)
    assert_respond_to Project, :active_projects
    assert_equal active_projects, Project.active_projects
  end
end
