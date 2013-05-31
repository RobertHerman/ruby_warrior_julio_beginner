class Player
  def initialize
    @previous_health = @MAX_HEALTH = 20
    @MIN_HEALTH_TO_FIGHT = 10
    @in_retreat = false
    @direction = :forward
    @aggression_factor = 0
  end
  
  def under_attack?
    @previous_health > @warrior.health
  end

  def turn_start()
    @in_retreat = true if !healthy_enough_to_fight?
    @space = @warrior.feel(@direction)
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
    return @warrior.pivot! if @space.wall?
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

  def healthy_enough_to_fight?
    @warrior.health >= (@MIN_HEALTH_TO_FIGHT - @aggression_factor)
  end
end
