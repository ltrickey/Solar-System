class Planet
  attr_reader :name, :diameter, :mass, :moons, :type, :distance_from_sun, :period_of_revolution

  def initialize(planet_hash)
    @name = planet_hash[:name]
    @diameter = planet_hash[:diameter]
    @mass = planet_hash[:mass]
    @moons = planet_hash[:moons]
    @type = planet_hash[:type]
    @distance_from_sun = planet_hash[:distance_from_sun]
    @period_of_revolution = planet_hash[:period_of_revolution]
  end

  def print_info
    "#{ @name.capitalize }:
    Number of moons: #{ @moons }
    Diameter: #{ @diameter } miles
    Mass: #{ @mass }
    Type: #{ @type }
    Distance from Sun: #{ @distance_from_sun } Million Miles
    1 revolution around the Sun: #{ @period_of_revolution } Earth Years"
  end

end

class Solar_System
  attr_accessor :number_of_planets, :moons, :planets
  attr_reader :age

  def initialize(list_of_planets, age, name)
    @number_of_planets = list_of_planets.length
    @planets = list_of_planets
    @age = age
    @name = name
  end

  def add_planets(additional_planets)
    additional_planets.each do |planet|
      if planet.class == Planet
        @planets << planet
        @number_of_planets += 1
      end
    end
  end

  def print_info
    @planets.each do |planet|
      puts planet.print_info
    end
  end

  def distance_between_planets(first_planet, second_planet)
    if (first_planet.distance_from_sun - second_planet.distance_from_sun) > 0
      "#{ first_planet.name.capitalize } is #{ first_planet.distance_from_sun - second_planet.distance_from_sun } million miles away from #{ second_planet.name.capitalize }"
    else
      "#{ first_planet.name.capitalize } is #{ second_planet.distance_from_sun - first_planet.distance_from_sun } million miles away from #{ second_planet.name.capitalize }"
    end
  end

  #method to find local year of planet
  #supposing all planets were created
  #at same time universe was created
  def local_year(planet)
      if planet.class == Planet
        planet_year = planet.period_of_revolution * @age
        @local_year = planet_year.to_i
        "On the planet #{ planet.name.capitalize } the year is #{ @local_year }."
      end
  end

end

earth_hash = {
  name: "earth",
  moons: 1,
  diameter: 7917.5,  #in miles
  mass: "5.972 × 10^24 kg",
  type: "Terrestrial",
  #distance_from_sun is in millions of miles
  distance_from_sun: 93,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 365.26 / 365.26
}
mars_hash = {
  name: "mars",
  moons: 2,
  diameter: 4212,  #in miles
  mass: "6.39 × 10^23 kg",
  type: "Terrestrial",
  #distance_from_sun is in millions of miles
  distance_from_sun: 141.6,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 686.98 / 365.26
}
uranus_hash = {
  name: "uranus",
  moons: 27,
  diameter: 31518,  #in miles
  mass: "8.681 × 10^25 kg",
  type: "Jovian",
  #distance_from_sun is in millions of miles
  distance_from_sun: 1784.0,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 30707.4082 / 365.26
}
jupiter_hash = {
  name: "jupiter",
  moons: 67,
  diameter: 86881.4,  #in miles
  mass: "1.898 × 10^27 kg",
  type: "Jovian",
  #distance_from_sun is in millions of miles
  distance_from_sun: 483.6,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 4332.71412 / 365.26
}
mercury_hash = {
  name: "mercury",
  moons: 0,
  diameter: 3032,  #in miles
  mass: "3.285 × 10^23 kg",
  type: "Terrestrial",
  #distance_from_sun is in millions of miles
  distance_from_sun: 36,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 87.96 / 365.26
}
saturn_hash = {
  name: "saturn",
  moons: 60,
  diameter: 72367.4,  #in miles
  mass: "5.683 × 10^26 kg",
  type: "Jovian",
  #distance_from_sun is in millions of miles
  distance_from_sun: 886.7,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 10759.0986 / 365.26
}
neptune_hash = {
  name: "neptune",
  moons: 14,
  diameter: 30599, #in miles
  mass: "1.024 × 10^26 kg",
  type: "Jovian",
  #distance_from_sun is in millions of miles
  distance_from_sun: 2794.4,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 60198.5006 / 365.26
}
venus_hash = {
  name: "venus",
  moons: 0,
  diameter: 7520.8, #in miles
  mass: "4.867 × 10^24 kg",
  type: "Terrestrial",
  #distance_from_sun is in millions of miles
  distance_from_sun: 67.2,
  #rate or time to revolve around sun in Earth years
  period_of_revolution: 224.68 / 365.26
}

earth = Planet.new(earth_hash)
mars = Planet.new(mars_hash)
uranus = Planet.new(uranus_hash)
jupiter = Planet.new(jupiter_hash)
mercury = Planet.new(mercury_hash)
saturn = Planet.new(saturn_hash)
neptune = Planet.new(neptune_hash)
venus = Planet.new(venus_hash)

planets_in_solar_system = [neptune, mars, uranus, jupiter, mercury, saturn, earth, venus]

milky_way = Solar_System.new(planets_in_solar_system, 4600000000, "Milky Way")

puts milky_way.distance_between_planets(earth, mars)

puts milky_way.local_year(mars)

#promts user to enter a planet
puts "Which planet would you like to learn more about?"
#lists possible planets
number = 1
planets_in_solar_system.each do |planet|
  puts "#{number}. #{planet.name.capitalize}"
  number += 1
end
planet_choice = gets.chomp.downcase

# prints out planet info until user wants to stop
while true
  planets_in_solar_system.each do |planet|
    if planet.name == planet_choice
      puts planet.print_info
    end
  end
  puts "\nWould you like to learn about one of these planets? Y/N?"
  learn_more = gets.chomp.downcase
    if learn_more == "yes" || learn_more == "y"
      puts "Great!  What other planet would you like to learn about?"
      planet_choice = gets.chomp.downcase
    else
      break
    end
end
