class CourseSerializer < CacheCrispies::Base
  serialize :id, to: String
  serialize(
    :title,
    :minutes,
    :published,
    :created_at,
    :updated_at
  )
  serialize :slides, with: SlideSerializer

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end