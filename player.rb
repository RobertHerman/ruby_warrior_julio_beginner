class Player
  def initialize
    @previous_health = @MAX_HEALTH = 20
    @MIN_HEALTH_TO_FIGHT = 8
    @under_attack = false
    @in_retreat = false
    @direction = :backward
    @warrior
    @space
    @aggression_factor = 0
  end
  
  def under_attack?
    return @under_attack
  end

  def turn_start()
    @under_attack = @previous_health > @warrior.health
    @in_retreat = true if @warrior.health < (@MIN_HEALTH_TO_FIGHT - @aggression_factor)
    @space = @warrior.feel(@direction)
    if @space.wall?
      @direction = :forward
      @space = @warrior.feel(@direction)
    end
  end

  def turn_end()
    @previous_health = @warrior.health
    @in_retreat = false if @previous_health == @MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior
    turn_start()
    determine_strategy()    
    turn_end()
  end

  def determine_strategy()
    return retreat() if @in_retreat and @warrior.health != @MAX_HEALTH
    return @warrior.rescue!(@direction) if @space.captive?
    return fight_or_flee() if under_attack?
    return @warrior.walk!(@direction) if @space.empty?
    @warrior.attack!
  end
 
  def fight_or_flee()
    return engage_enemy() if @warrior.health >= (@MIN_HEALTH_TO_FIGHT - @aggression_factor)
    retreat()
  end

  def retreat()
    @aggression_factor = 0
    return @warrior.walk!(:backward) if under_attack?
    @warrior.rest!
  end

  def engage_enemy()
    if @space.empty?  #if this is an archer we have to be more aggressive and close the gap
      @warrior.walk!(@direction)
      @aggression_factor = 4
    else
      @warrior.attack!(@direction)
    end
  end
end
