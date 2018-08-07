class Api::V1::OwnerSerializer < ActiveModel::Serializer
    attributes :name, :image, :dogs
end
