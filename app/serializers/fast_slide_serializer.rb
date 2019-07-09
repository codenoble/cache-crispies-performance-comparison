class FastSlideSerializer
  include FastJsonapi::ObjectSerializer

  attribute(:id) { |obj| obj.id.to_s }

  attributes(
    :content,
    :order
  )
  attribute(:created_at) { |obj| obj.created_at.iso8601 }
  attribute(:updated_at) { |obj| obj.updated_at.iso8601 }
end