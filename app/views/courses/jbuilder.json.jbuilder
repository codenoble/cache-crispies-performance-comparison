json.courses @courses do |course|
  json.id         course.id.to_s
  json.title      course.title
  json.minutes    course.minutes
  json.published  course.published
  json.created_at course.created_at.iso8601
  json.updated_at course.updated_at.iso8601
  if course.published?
    json.slides do
      json.array!(course.slides, partial: 'slides/slide', as: :slide)
    end
  end
end
