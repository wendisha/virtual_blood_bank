class ClinicSerializer < ActiveModel::Serializer
  attributes :id, :name, :state

  # has_many :appointments
  # has_many :donors, through: :appointments
end
