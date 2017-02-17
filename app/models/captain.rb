class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators

    # all.joins(:boat_classifications, :classifications).where("classifications.name = 'Catamaran'").distinct
    all.joins(boats: :classifications).where(
      classifications: {name: "Catamaran"}

    )
  end

  def self.sailors
      # all.joins(:boat_classifications, :classifications).where("classifications.name = 'Sailboat'").distinct
      get
      all.joins(boats: :classifications).where(classifications)
  end

  def self.with_classificaitons
      joins(boats: :classifications)
  end

  def self.sailors
    get_boat_type("Sailboat")
  end

  def self.get_boat_type(x)
     with_classificaitons.where(classifications: { name:x }).uniq
  end

  def self.talented_seamen

    # motor = all.joins(:classifications).where(classifications: {name: ['Motorboat']})
    # sail = all.joins(:classifications).where(classifications: {name: ['Sailboat']})
    #
    #
    # find_by_sql("#{motor.to_sql} INTERSECT #{sail.to_sql}")


    # and classifications.name = ?", 'Sailboat',
    all.joins(:boat_classifications, :classifications).where(classifications: {name: ['Motorboat', 'Sailboat']}).group("classifications.name").order("captains.name")
  end

  def self.non_sailors

    all.joins(:boat_classifications, :classifications).select("captains.name").where.not(captains: {name: sailors.pluck}).distinct
  end
end
