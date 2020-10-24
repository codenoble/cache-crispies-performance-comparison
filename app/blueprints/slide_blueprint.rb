class SlideBlueprint < Blueprinter::Base
  identifier :id do |slide, _options|
    slide.id.to_s
  end

  fields(
    :content,
    :order,
    :created_at,
    :updated_at
  )
end
