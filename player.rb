class Player
  MAX_HEALTH = 20
  MIN_HEALTH = 6
 
  def play_turn(warrior)
    if warrior.feel.empty?
      if warrior.health >  MIN_HEALTH
        warrior.walk!
      else
        warrior.rest!
      end
    else
      warrior.attack!
    end
  end
end
