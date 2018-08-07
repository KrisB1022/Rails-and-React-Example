class Api::V1::SitterSerializer < ActiveModel::Serializer
    attributes :id, :name, :image, :ratings_score
end
