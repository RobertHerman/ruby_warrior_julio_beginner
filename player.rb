class Player
  def initialize
    @health = @MAX_HEALTH = 20
    @MIN_HEALTH_TO_FIGHT = 8
    @under_attack = false
    @in_retreat = false
    @direction = :backward
    @warrior
    @space
    @fudge = 0
  end
  
  def under_attack?
    return @under_attack
  end

  def turn_start()
    @under_attack = @health > @warrior.health
    @in_retreat = true if @warrior.health < (@MIN_HEALTH_TO_FIGHT + @fudge)
    @space = @warrior.feel(@direction)
    if @space.wall?
      @direction = :forward
      @space = @warrior.feel(@direction)
    end
  end

  def turn_end()
    @health = @warrior.health
    @in_retreat = false if @health == @MAX_HEALTH
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
    return engage_enemy() if @warrior.health >= (@MIN_HEALTH_TO_FIGHT + @fudge)
    retreat()
  end

  def retreat()
    @fudge = 0
    return @warrior.walk!(:backward) if under_attack?
    @warrior.rest!
  end

  def engage_enemy()
    if @space.empty?
      @warrior.walk!(@direction)
      @fudge = -4
    else
      @warrior.attack!(@direction)
    end
  end
end
