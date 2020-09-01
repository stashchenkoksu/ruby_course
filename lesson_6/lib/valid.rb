module Valid
	def valid?
		valid!
		true
	rescue
		false
	end
end
