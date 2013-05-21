class Player
  def initialize
    @MAX_HEALTH = 20
    @health = @MAX_HEALTH
    @MIN_HEALTH_TO_FIGHT = 13
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
    return engage_enemy(warrior) if under_attack?
    return warrior.rescue! if warrior.feel.captive?
    return warrior.attack! unless warrior.feel.empty?
    if warrior.health < @MIN_HEALTH_TO_FIGHT
      warrior.rest!
    else
      warrior.walk!
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
