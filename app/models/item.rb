class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items

  def price_to_currency
    (price.to_f / 100)
  end
end
