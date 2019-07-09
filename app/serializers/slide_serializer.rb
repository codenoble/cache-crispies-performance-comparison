class SlideSerializer < CacheCrispies::Base
  serialize :id, to: String
  serialize(
    :content,
    :order,
    :created_at,
    :updated_at
  )

  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end