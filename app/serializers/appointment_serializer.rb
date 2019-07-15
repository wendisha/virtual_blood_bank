class AppointmentSerializer < ActiveModel::Serializer
  #Pick and choose what we want to render as json
  attributes :id, :donor_id, :clinic_id, :date, :time, :donor_username, :clinic_name

  #add associations????
  # belongs_to :donor
  # belongs_to :clinic

  def donor_username
    d = object.donor 
    #{username: d.username}
    d.username
  end

  def clinic_name
    c = object.clinic
    c.name
  end
end
