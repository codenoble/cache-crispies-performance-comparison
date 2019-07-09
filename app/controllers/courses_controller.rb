class CoursesController < ApplicationController
  include ::CacheCrispies::Controller

  before_action :set_courses

  def jbuilder
  end

  def cache_crispies
    cache_render(
      CourseSerializer,
      @courses
    )
  end

  private

  def set_courses
    @courses = Course.includes(:slides).all
  end
end