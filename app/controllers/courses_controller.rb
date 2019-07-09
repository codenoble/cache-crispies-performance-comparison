class CoursesController < ApplicationController
  before_action :set_courses

  def jbuilder
  end

  private

  def set_courses
    @courses = Course.includes(:slides).all
  end
end