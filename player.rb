class Player
  def initialize
    @MAX_HEALTH = 20
    @health = @MAX_HEALTH
    @MIN_HEALTH_TO_FIGHT = 13
    @under_attack;
    @warrior;
  end
  
  def under_attack?
    return @under_attack
  end

  def turn_start()
    @under_attack = @health > @warrior.health
  end

  def turn_end()
    @health = @warrior.health
  end

  def play_turn(warrior)
    @warrior = warrior
    turn_start()
    determine_strategy()    
    turn_end()
  end

  def determine_strategy()
    return engage_enemy() if under_attack?
    return @warrior.rescue! if @warrior.feel.captive?
    return @warrior.attack! unless @warrior.feel.empty?
    if @warrior.health < @MIN_HEALTH_TO_FIGHT
      @warrior.rest!
    else
      @warrior.walk!
    end
  end

  def engage_enemy()
    # if the enemy is an archer then there is a gap to close
    if @warrior.feel.empty?
      @warrior.walk!
    else
      @warrior.attack!
    end
  end
end
