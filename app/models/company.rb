class Company < ApplicationRecord
  has_rich_text :description
  validates :email, allow_blank: true, email: true
  before_save :update_city_state, if: :zip_code_changed?

  private

  def update_city_state
    zipcode_decoded = ZipCodes.identify(zip_code) || {}
    self.city = zipcode_decoded[:city]
    self.state = zipcode_decoded[:state_code]
  end

end
