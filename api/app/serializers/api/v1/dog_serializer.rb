class Api::V1::DogSerializer < ActiveModel::Serializer
    attributes :name, :owner_id
    belongs_to :owner
end
