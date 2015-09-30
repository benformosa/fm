class Settings < RailsSettings::CachedSettings
  def convert_to_number
    self.value = self.value.to_f
  end
end
