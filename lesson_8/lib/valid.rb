module Valid
  def valid?
    valid!
    true
  rescue StandardError
    false
  end
end
