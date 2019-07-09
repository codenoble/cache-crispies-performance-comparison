class FastCourseSerializer
  include FastJsonapi::ObjectSerializer

  attribute(:id) { |obj| obj.id.to_s }

  attributes(
    :title,
    :minutes,
    :published,
  )
  attribute(:created_at) { |obj| obj.created_at.iso8601 }
  attribute(:updated_at) { |obj| obj.updated_at.iso8601 }

  has_many :slides, serializer: FastSlideSerializer
end