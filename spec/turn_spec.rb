require 'rspec'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/player.rb'
require './lib/turn.rb'

describe Turn do

  before :each do
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@turn).to be_an_instance_of(Turn)
    end

    it 'has readable attributes' do
      expect(@turn.player1).to eq(@player1)
      expect(@turn.player2).to eq(@player2)
      expect(@turn.spoils_of_war).to eq([])
    end
  end


  describe '#basic turn' do

    it 'is a basic turn' do
      expect(@turn.type).to eq(:basic)
    end

    it 'has a winner' do
      @turn.type
      expect(@turn.winner).to eq(@player1)
    end

    it "moves both 'played' cards to the spoils_of_war" do
      expect(@turn.spoils_of_war).to eq([])

      @turn.type
      @turn.winner
      @turn.pile_cards
      expect(@turn.spoils_of_war).to include(@card1)
      expect(@turn.spoils_of_War).to include(@card3)
      expect(@turn.player1.deck).to eq([@card2, @card5, @card8])
      expect(@turn.player2.deck).to eq([@card4, @card6, @card7])
    end

    it "awards the spoils to the winner" do
      winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(winner)

      expect(winner.deck).to include(@card1)
      expect(winner.deck).to include(@card3)
      expect(@player1.deck.size).to eq(4)
      expect(@player2.deck.size).to eq(2)
    end
  end
end
