class Merchant < ApplicationRecord
  has_many :items

  def self.find_name(name)
    where('lower(name) LIKE ?', "%" + name.downcase + "%")
    .order('name')
  end
end