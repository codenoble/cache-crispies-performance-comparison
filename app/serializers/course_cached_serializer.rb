class CourseCachedSerializer < CacheCrispies::Base
  key :course
  do_caching true

  serialize :id, to: String
  serialize(
    :title,
    :minutes,
    :published,
    :created_at,
    :updated_at
  )

  show_if(->(course) { course.published? }) do
    serialize :slides, with: SlideSerializer
  end

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
