class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all

    all.joins(:boat_classifications).distinct
  end

  def self.longest
    
    # type = select("boats.name").joins(boats: :boat_classifications).group("boats.name").order("boats.length desc").limit(1)
    Boat.joins(:classifications).order("boats.length desc").first.classifications

    # self.joins(:boats).order("boats.length desc")

  end
end
