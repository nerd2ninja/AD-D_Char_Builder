#Roll for stats
def stat_roll
  $stat_die_1 = SecureRandom.random_number(1..6)
  $stat_die_2 = SecureRandom.random_number(1..6)
  $stat_die_3 = SecureRandom.random_number(1..6)
  $stat_die_4 = SecureRandom.random_number(1..6)
  $stat_die_5 = SecureRandom.random_number(1..6)
  $stat_die_6 = SecureRandom.random_number(1..6)
  $stat_die_7 = SecureRandom.random_number(1..6)
end

#stat me up
def stat_me_up
  $player_stats = {str: 0, dex: 0, con: 0, int: 0, wis: 0, cha: 0}
  #Base stats
  base_stat = {str: 8, dex: 8, con: 8, int: 8, wis: 8, cha: 8}
  stat_die = [$stat_die_1, $stat_die_2, $stat_die_3, $stat_die_4, $stat_die_5, $stat_die_6, $stat_die_7]

  $player_stats.merge!(base_stat) { |k, o, n| o + n }

  puts "Remember, the minimum stats for each class are as follows:"
  puts $class_min
  puts "Your base stats are as follows:"
  puts $player_stats
  puts "Now lets add each roll to your stats. You can add multiple rolls to a single stat."
  puts "Type that stat you'd like to add your roll to. To add your roll to str for example, type 'str'"
  puts "You rolled #{stat_die}"

  stat_die.each {|roll|
    check = 0
    puts "where would you like your roll of #{roll} to go?"
    until check == 1
      input = gets.chomp
      unless $player_stats[:"#{input}"] == nil
        
        if $player_stats[:"#{input}"] + roll <= 18
          $player_stats[:"#{input}"] = $player_stats[:"#{input}"] + roll
          check = 1
        else
          puts "You can not increase your stats above 18"
        end
      else
        puts "Whoops. You may have mistyped. Valid options are 'str', 'dex', 'con', 'int', 'wis', 'cha'"
      end
      puts $player_stats
    end
  }
end

#Allow the player to select a class
def class_selection
  puts "Remember, you need the following stats for each class"
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
  puts $class_min
  puts "Which class would you like to play?"
  #Minimum stat requirements for classes
  fighter = {str: 9, dex: 0, con: 0, int: 0, wis: 0, cha: 0}
  paladin = {str: 12, dex: 0, con: 9, int: 0, wis: 13, cha: 17}
  ranger = {str: 13, dex: 13, con: 14, int: 0, wis: 14, cha: 0}
  mage = {str: 0, dex: 0, con: 0, int: 9, wis: 0, cha: 0}
  cleric = {str: 0, dex: 0, con: 0, int: 0, wis: 9, cha: 0}
  druid = {str: 0, dex: 0, con: 0, int: 0, wis: 12, cha: 15}
  thief = {str: 0, dex: 9, con: 0, int: 0, wis: 0, cha: 0}
  bard = {str: 0, dex: 12, con: 0, int: 13, wis: 0, cha: 15}
  #Come back to this. Probably different for every specialty
  specialist_wizard = nil 
  illusionist = nil

  all_classes = [fighter, paladin, ranger, mage, specialist_wizard, cleric, druid, thief, bard]

  #stats
  stat_types = ["str", "dex", "con", "int", "wis", "cha"]
  validation = Array.new
  
  until validation == ["pass", "pass", "pass", "pass", "pass", "pass"]
    pass = false
    input = gets.chomp
    
    unless $player_race == ["Please run 'choose race'"]
      $player_race[1].each {|check|
        if check == input.downcase
          pass = true
        end
      }
      if pass == false
        puts "Selected player race can not play as selected player class"
      end
    else
      pass = true
    end

    unless pass == false
    
      case input
        when "fighter"
          validate_class = fighter
        when "paladin"
          validate_class = paladin
        when "ranger"
          validate_class = ranger
        when "mage"
          validate_class = mage
        when "specialist_wizard"
          validate_class = specialist_wizard
        when "cleric"
          validate_class = cleric
        when "druid"
          validate_class = druid
        when "thief"
          validate_class = thief
        when "bard"
          validate_class = bard
      else
        validate_class = nil
      end
  
      unless validate_class == nil
        validation = Array.new
        validate = $player_stats.merge(validate_class) { |k, o, n| o - n }
    
        validate.each_with_index {|stat, type|
        extract = stat_types[type]
        
          if validate[:"#{extract}"] <= 0
            puts "Your #{extract} is too low to use that class"
            validation.push("failed")
          else
            validation.push("pass")
          end
        }
      $player_class = input
    else
      puts "Selected player race can not play as selected player class"
    end
  end
end
end

#Allow the player to select their player race
def race_selection
  all_classes = ["fighter", "paladin", "ranger", "mage", "specialist_wizard", "cleric", "druid", "thief", "bard"]
#Racial stat modifiers and class limitations
  
  elf_stat = {str: 0, dex: 1, con: -1, int: 0, wis: 0, cha: 0}
  elf_class = ["cleric", "fighter", "mage", "thief", "ranger"]
  elf = [elf_stat, elf_class]
  
  gnome_stat = {str: 0, dex: 0, con: 0, int: 1, wis: -1, cha: 0}
  gnome_class = ["fighter", "thief", "cleric", "illusionist"]
  gnome = [gnome_stat, gnome_class]
  
  halfelf_stat = {str: 0, dex: 0, con: 0, int: 0, wis: 0, cha: 0}
  halfelf_class = ["cleric", "druid", "fighter", "ranger", "mage", "specialist_wizard", "thief", "bard"]
  halfelf = [halfelf_stat, halfelf_class]
  
  halfling_stat = {str: -1, dex: 1, con: 0, int: 0, wis: 0, cha: 0}
  halfling_class = ["cleric", "fighter", "thief"]
  halfling = [halfling_stat, halfling_class]
  
  human_stat = {str: 0, dex: 0, con: 0, int: 0, wis: 0, cha: 0}
  human_class = all_classes
  human = [human_stat, human_class]
  
  puts "Choose race"
  puts "Type 'Racial Modifiers' to see how your stat will be affected"
  puts "Type 'race classes' to see how your race choice will affect your class options"
race_string = <<-String
  Elf
  Gnonme
  Half-Elf
  Halfling
  Human
String
  
  puts race_string
  pass = false
  player_race = nil

  unless $player_race == ["Please run 'choose race'"]
    $player_stats.merge!($player_race[2]) { |k, o, n| o - n }
    $player_race = ["Please run 'choose race'"]
  end
  
  while player_race == nil
  input = gets.chomp
    case input.downcase
      when "elf"
        player_race = elf
      when "gnome"
        player_race = gnome
      when "half-elf"
        player_race = halfelf
      when "halfling"
        player_race = halfling
      when "human"
        player_race = human
      when "racial modifiers"
        puts $racial_modifiers
      when "race classes"
        puts $race_classes
    else
      puts "Whoops, think you mistyped. Try again."
    end
#Check if a class has been selected and if so, check if player_race can play as that class
    if $player_class == "Please run 'choose class'"
      pass = true
    end
    unless player_race == nil or $player_class == "Please run 'choose class'"
      player_race[1].each { |check|
        if check == $player_class
          pass = true
        end
      }
    end
#Apply racial modifiers
    unless pass == false or player_race == nil
      $player_stats.merge!(player_race[0]) { |k, o, n| o + n }
      $player_race = [input.downcase, player_race[1], player_race[0]]
    else
      player_race = nil
      puts "Selected player race can not play selected player class"
    end
  end
end

#Allow player to name their character
def char_name
 input = gets.chomp
  $char_name = input
end
