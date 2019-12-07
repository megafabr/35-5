class Movie
  attr_reader :year, :title, :director

  def initialize(year, title, director)
    @year = year
    @title = title
    @director = director
  end

  def to_s
    "#{@director} - #{@title} (#{@year})"
  end
end