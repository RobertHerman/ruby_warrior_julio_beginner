class Player
  def initialize
    @max_health = 20
    @health = @max_health
    @min_health_to_fight = 13
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
    if under_attack?
      engage_enemy(warrior)
      return
    end

    if warrior.feel.captive?
      warrior.rescue!
      return
    end

    if warrior.feel.empty?
      if warrior.health < @min_health_to_fight
        warrior.rest!
      else
        warrior.walk!
      end
    else
        warrior.attack!
    end
  end

  def engage_enemy(warrior)
    # if the enemy is an archer then there is a gap to close
    if warrior.feel.empty?
      warrior.walk!
    else
      warrior.attack!
    end
  end
end
