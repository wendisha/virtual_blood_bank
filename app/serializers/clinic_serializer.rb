class ClinicSerializer < ActiveModel::Serializer
  attributes :id, :name, :state

  # has_many :appointments
  # has_many :donors, through: :appointments
end




#serializer is to format the data in our db from the associations that have been setup.