class ValidCoordinate < ApplicationRecord
  has_and_belongs_to_many :coordinate

  def first_name=(s)
    write_attribute(:first_name, s.to_s.capitalize.gsub( /[^A-Za-zéô]+/, '' )) # The to_s is in case you get nil/non-string
  end

  def last_name=(s)
    write_attribute(:last_name, s.to_s.capitalize.gsub( /[^A-Za-zéô]+/, '' )) # The to_s is in case you get nil/non-string
  end

  def email=(s)
    write_attribute(:email, s.to_s.gsub( /[^A-Za-z.@]+/, '' )) # The to_s is in case you get nil/non-string
  end
end
