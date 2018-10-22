class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    where(self.arel_table[:length].lt(20))
  end

  def self.ship
    self.where(self.arel_table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    self.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
    self.where(:captain => nil)
  end

  def self.sailboats
    self.includes(:classifications).where('classifications.name = "Sailboat"')
  end

  def self.with_three_classifications
    # joins(:classifications).group('boat.id').having('count(classifications) > 2')
  end
end
