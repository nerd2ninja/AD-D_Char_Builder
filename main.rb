require 'securerandom'
require_relative 'definitions.rb'
#require_relative 'spells.rb'

#Initialize
  $char_name = "Please run 'char name'"
  $player_stats = "Please run 'stat me up'"
  $player_race = ["Please run 'choose race'"]
  $player_class = "Please run 'choose class'"
#Roll for stats
$stat_die_1 = 0
$stat_die_2 = 0
$stat_die_3 = 0
$stat_die_4 = 0
$stat_die_5 = 0
$stat_die_6 = 0
$stat_die_7 = 0

puts "Hello adventurer. Welcome to Advanced Dungeons and Dragons."
puts "To begin, lets start by rolling your stats"
puts "Would you like to roll your stats yourself? Otherwise, I can roll for you."
puts "Please type 'I rolled' if you've rolled your own stats. Otherwise, type 'You roll'"

#def rollstats
  while $stat_die_1 == 0
    stat_roll_select = gets.chomp
    if stat_roll_select.downcase == "i rolled"
      puts "Please enter what you rolled, then press enter to entry the next number you rolled."
      $stat_die_1 = gets.chomp.to_i
      $stat_die_2 = gets.chomp.to_i
      $stat_die_3 = gets.chomp.to_i
      $stat_die_4 = gets.chomp.to_i
      $stat_die_5 = gets.chomp.to_i
      $stat_die_6 = gets.chomp.to_i
      $stat_die_7 = gets.chomp.to_i
    elsif stat_roll_select.downcase == "you roll"
      stat_roll
    else
      puts "I'm sorry. Maybe you made a typo. Type 'I rolled' if you rolled already, or type 'You roll' if you want me to roll"
    end
  end
#end

stat_die = [$stat_die_1, $stat_die_2, $stat_die_3, $stat_die_4, $stat_die_5, $stat_die_6, $stat_die_7]

system "clear"

puts "Okay, this is what you rolled #{stat_die}"
puts "You can add each of these numbers to your stats and you can even add more than one of them to a single stat. Each stat starts as an 8"
puts "Remember, stat modifiers from your race choice will also impact your stats."
puts "Your stats and race impact which class you can choose"
puts "If you would like to see the minimum stat requirements for each class, type 'Class requirements'"
puts "If you would like to see what class each race can play, type 'Race class options'"
puts "If you would like to see have each race choice will affect your stats, type 'racial stat modifiers'"
puts "If you're ready to allocate your rolls to your stat blocks, type 'Stat me up'"

$class_min = <<-STRING
fighter = str: 9
paladin = str: 12, con: 9, wis: 13, cha: 17
ranger = str: 13, dex: 13, con: 14, wis: 14
mage = int: 9
cleric = wis: 9
druid = wis: 12, cha: 15
thief = dex: 9
bard = dex: 12, int: 13, cha: 15
STRING

$race_classes = <<-STRING
elf_class = cleric, fighter, mage, thief, ranger

gnome_class = fighter, thief, cleric, illusionist

halfelf_class = cleric, druid, fighter, ranger, mage, specialist_wizard, thief, bard

halfling_class = cleric, fighter, thief

human_class = all classes
STRING

$racial_modifiers = <<-STRING
elf_stat = dex: 1, con: -1
gnome_stat = int: 1, wis: -1
halfelf_stat = No racial modifiers
halfling_stat = str: -1, dex: 1
human_stat = No racial modifiers
STRING

#Player selection basically works like terminal commands. This is effectively the main menu after the introduction.
player_selection = "default"
until player_selection.downcase == "exit"
  player_selection = gets.chomp
  
  case  player_selection.downcase
  when "class requirements"
    system "clear"
    puts "The following, is the minimum stat requirements for each class."
  puts $class_min
  when "race class options"
    system "clear"
    puts "The following is the list of classes each race can play"
    puts $race_classes
  when "racial stat modifiers"
    system "clear"
    puts "The following will be added or subtracted to your stats after you allocate your rolls to them."
    puts "Remember, you can not add your rolls to a stat if it puts that stat above 18, but racial modifiers ignore this rule, allowing you to go above 18."
    puts $racial_modifiers
  when "stat me up"
    system "clear"
    stat_me_up
    puts "You've allocated all your rolls!"
    puts "Welcome back to the main menu. Next suggested option, 'choose race'"
  when "choose race"
    system "clear"
    race_selection
    puts "Done Choosing race!"
    puts "Welcome back to the main menu. Next suggested option, 'choose class'"
  when "choose class"
    system "clear"
    class_selection
    puts "Class selected"
    puts "Welcome back to the main menu. Next suggested option, 'char name'"
  when "char name"
    puts "What is your characters name?"
    char_name
  when "show sheet"
    system "clear"
    sheet = "Name: #{$char_name}\n Stats: #{$player_stats}\n Race: #{$player_race[0]}\n Class: #{$player_class}"
    puts sheet
  else
    puts "Sorry, maybe that was a typo. Try again."
  end
end

#TODO add a save feature
