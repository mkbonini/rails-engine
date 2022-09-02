class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant
  belongs_to :merchant
  # has_many :invoice_items
  # has_many :invoices, through: :invoice_items

  def self.find_name(name)
    where('lower(name) LIKE ?', "%" + name.downcase + "%")
    .order('name')
  end

  def self.find_min(min)
    where('unit_price >= ?',  min)
    .order('name')
  end

  def self.find_max(max)
    where('unit_price <= ?',  max)
    .order('name')
  end

  def self.find_min_max(min,max)
    where('unit_price <= ? AND unit_price >= ?',  max, min)
    .order('name')
  end
end