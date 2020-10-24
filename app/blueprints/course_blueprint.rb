class CourseBlueprint < Blueprinter::Base
  identifier :id do |course, _options|
    course.id.to_s
  end

  fields(
    :title,
    :minutes,
    :published,
    :created_at,
    :updated_at
  )

  association :slides, blueprint: SlideBlueprint, if: ->(_field_name, course, _options) { course.published? }
end
