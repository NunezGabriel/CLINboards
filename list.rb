require_relative "cards"
require "json"

class List
  attr_reader :list, :cards, :id
  attr_accessor :name

  @@id = nil

  def initialize(id:nil, name:, cards: [])
    @id = id
    @name = name
    @cards = load(cards) || []
  end



  def delete_list(value)
    @cards.delete_if{|hash| hash[:name] == value}
  end

  def create_new_card(name_list = "todo", data)
    newcard = Cards.new(**data)
    @cards << newcard
  end

  def update_actual_card(id,name_list,data)
    @cards.each do |card|
      if card.id == id
       card.update_card(**data)
      end
    end
    @cards
  end

  def delete_card(id)
    cards = @cards.find { |hash| hash[:cards].find {|card| card.id == id }}
    cards[:cards].delete_if { |card| card.id == id }
  end


  def to_json(arg)
    JSON.pretty_generate({
      id: @id,
      name: @name, 
      cards: @cards, 
    })
  end

  private
  

  def load(cards)
    cards.map { |card| Cards.new(**card)}
  end

  def next_id
    @@id = @cards.size + 1
  end

end

