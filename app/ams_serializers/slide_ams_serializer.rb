class SlideAmsSerializer < ActiveModel::Serializer
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
end
