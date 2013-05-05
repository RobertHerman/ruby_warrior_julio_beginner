class Player
  def initialize
    @max_health = 20
    @health = @max_health
    @min_health_to_fight = 12
    @under_attack;
  end
  
  def under_attack?
    return @under_attack
  end

  def turn_start(warrior)
    @under_attack = @health > warrior.health
  end

  def turn_end(warrior)
    @health = warrior.health
  end

  def play_turn(warrior)
    turn_start(warrior)
    determine_strategy(warrior)    
    turn_end(warrior)
  end

  def determine_strategy(warrior)
    if under_attack? == true
      if warrior.feel.empty?
        warrior.walk!
      else
        warrior.attack!
      end
      return
    end

    if warrior.feel.empty? == true
      if warrior.health < @min_health_to_fight
        warrior.rest!
      else
        warrior.walk!
      end
    else
        warrior.attack!
    end
  end
end
