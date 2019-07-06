class AppointmentSerializer < ActiveModel::Serializer
  #Pick and choose what we want to render as json
  attributes :id, :donor_id, :clinic_id, :date, :time

  #add associations????
  belongs_to :donor
end