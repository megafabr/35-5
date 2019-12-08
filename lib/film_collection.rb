class FilmCollection

  attr_accessor :films, :directors

  def self.films_used_oga
    url = 'https://www.imdb.com/list/ls052535080/?sort=list_order,asc&st_dt=&mode=detail&page=10'
    html = open(url)
    doc = Oga.parse_html(html)

    films = []
    doc.css('.lister-item-content').each do |m|
      year = m.at_css('.lister-item-year').text.delete('()').to_i
      title = m.at_css('a').text.strip
      director = m.css('p')[2].text.split('|')[0].split("\n")[2]

      films << Film.new(year, title, director) if year != 0
    end

    new(films)
  end

  def initialize(films = [])
    @films = films
    @directors =  @films.map(&:director).uniq.sort
  end

  def directors_list
    @directors.map.with_index(1) do |director, index|
      "#{index}. #{director}"
    end
  end

  def film_today(director)
    @films.select { |film| film.director == director }.sample
  end
end