class PankoCourseSerializer < Panko::Serializer
  attributes(
    :id,
    :title,
    :minutes,
    :published,
    :created_at,
    :updated_at
  )

  has_many :slides, each_serializer: PankoSlideSerializer

  def id
    object.id.to_s
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
