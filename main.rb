# Для подключения всех необходимых gems установите bundler (gem install bundler)

require 'oga'
require 'open-uri'
require_relative 'lib/movie'

films = []
count = 0

# Все что связано с конкрктным сайтом
URI_MASSIV = [
  'https://www.imdb.com/list/ls052535080/?sort=list_order,asc&st_dt=&mode=detail&page=10'
  ]
1.times do
  url = URI_MASSIV[count]
  count += 1
  html = open(url)

  doc = Oga.parse_html(html)
  doc.css('.lister-item-content').each do |m|
    year = m.at_css('.lister-item-year').text.delete('()').to_i
    title = m.at_css('a').text.strip
    director = m.css('p')[2].text.split('|')[0].split("\n")[2]

    films << Movie.new(year, title, director)
  end
end
# ----------------------------------------------------------------

puts 'Программа "Фильм на вечер"'

directors_list = films.map { |f| f.director }.uniq.sort

directors_list.each.with_index(1) do |director, index|
  puts "#{index}. #{director}"
end

puts
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"
user_input = gets.to_i

if user_input > 0 && directors_list.fetch(user_input - 1)
  director = directors_list.fetch(user_input - 1)
end

film_today = films.map { |film| film if film.director == director }.compact

puts "Сегодня вечером рекомендую посмотреть:"
puts film_today.sample(1)
