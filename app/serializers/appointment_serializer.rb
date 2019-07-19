class AppointmentSerializer < ActiveModel::Serializer
  #Pick and choose what we want to render as json
  attributes :id, :donor_id, :clinic_id, :date, :time, :donor_username, :clinic_name, :date_formatted, :time_formatted

  #Better not to have the associations because it will give access to the whole donor object, including the authenticity token
  # belongs_to :donor
  # belongs_to :clinic

  #to specify which data I want to present as JSON and how I want present it.
  def donor_username
    d = object.donor 
    #{username: d.username}
    d.username
  end

  def clinic_name
    c = object.clinic
    c.name
  end

  def date_formatted
    d_f = object.date
    d_f.strftime("%B %d, %Y")
  end

  def time_formatted
    t_f = object.time
    t_f.strftime("%l:%M%p")
  end
end

#HTML: how te contect is laid-out
#CSS: how the content looks
#JS: how the content behaves
