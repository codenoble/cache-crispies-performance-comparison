class CoursesController < ApplicationController
  include ::CacheCrispies::Controller

  before_action :set_courses

  def jbuilder
  end

  def cache_crispies
    cache_render CourseSerializer, @courses
  end

  def cache_crispies_cached
    cache_render CourseCachedSerializer, @courses
  end

  def fast_jsonapi
    render(
      json: FastCourseSerializer.new(
        @courses,
        include: [:slides]
      )
    )
  end

  def blueprinter
    render(json: CourseBlueprint.render_as_json(@courses))
  end

  def active_model_serializer
    render json: @courses, each_serializer: CourseAmsSerializer, root: false
  end

  private

  def set_courses
    @courses = Course.includes(:slides).all
  end
end
