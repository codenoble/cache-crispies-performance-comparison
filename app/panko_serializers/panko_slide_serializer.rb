class PankoSlideSerializer < Panko::Serializer
  attributes(
    :id,
    :content,
    :order,
    :created_at,
    :updated_at
  )

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
