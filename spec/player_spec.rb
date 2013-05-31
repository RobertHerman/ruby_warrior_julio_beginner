require File.dirname(__FILE__) + '/../player.rb'

describe "Players action" do
  let(:player) { Player.new }

  before do
    @warrior = mock()
    @space = mock()
    @space.stub!(:empty?).and_return(true)
    @space.stub(:wall?).and_return(false)
    @space.stub(:captive?).and_return(false)
    @space.stub!(:enemy?).and_return(false)
    @warrior.stub!(:feel).and_return(@space)
    @warrior.stub!(:health).and_return(20)
  end

  it "should walk forward when @space is empty" do
    @warrior.should_receive(:walk!).with(:forward)
    player.play_turn(@warrior)
  end

  it "should attack enemies in its way" do
    @space.stub!(:enemy?).and_return(true)
    @space.stub!(:empty?).and_return(false)
    @warrior.should_receive(:attack!)
    player.play_turn(@warrior)
  end

  it "should attack close the gap on range attacking enemy" do
    @warrior.should_receive(:walk!)
    @warrior.stub!(:health).and_return(20, 17, 14)
    player.play_turn(@warrior)
  end

  it "should retreat when health is too low to continue fighting" do
    @warrior.stub!(:health).and_return(6)
    @warrior.should_receive(:walk!).with(:backward)
    player.play_turn(@warrior)
    @warrior.should_receive(:rest!)
    player.play_turn(@warrior)
  end

  it "should rescue captives" do
    @space.stub!(:empty?).and_return(false)
    @space.stub!(:captive?).and_return(true)
    @warrior.should_receive(:rescue!)
    player.play_turn(@warrior)
  end

  it "should turn around if it sees a wall" do
    @space.stub!(:wall?).and_return(true)
    @warrior.should_receive(:pivot!)
    player.play_turn(@warrior)
  end
end
