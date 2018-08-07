class Api::V1::ReviewSerializer < ActiveModel::Serializer
    attributes :rating, :text, :sitter_id
    belongs_to :sitter
end
