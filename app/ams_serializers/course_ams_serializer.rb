class CourseAmsSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :minutes,
    :published,
    :created_at,
    :updated_at
  )

  has_many :slides, serializer: SlideAmsSerializer, if: -> { object.published? }

  def id
    object.id.to_s
  end
end
