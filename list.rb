require_relative "cards"
require "json"

class List
  attr_reader :list

  @@id = nil

  def initialize(id:, name:, card: nil)
    @id = id
    @name = name
    @cards = card || []
  end


  def create_list(value)
    hash = {id: next_id, name:value, cards: []}
    @cards << hash
  end

  def update_list(name, new_name)
    @cards.find do |hash|
      if hash[:name] == name
        hash[:name] = new_name
      end
    end
  end

  def delete_list(value)
    @cards.delete_if{|hash| hash[:name] == value}
  end

  def create_card(name_list = "todo", value)
    newcard = Cards.new(**value)
    @cards.find do |hash|
      if hash[:name] == name_list
        hash[:cards] << newcard
      end
    end
  end

  def update_cards(id,name_list,value)
    cards = @cards.find { |hash| hash[:cards].find {|card| card.id == id }}

    cards[:cards].each do |card|
      if card.id == id
       card.update_card(**value)
      end
    end

    new_card = @cards.find { |hash| hash[:cards].find {|card| card.id == id }}

    @cards.each do |hash|
      if hash[:name] != name_list
        new_hash = @cards.find { |hash| hash[:name] == name_list }
        new_hash[:cards].concat(new_card[:cards])
        break
      end
    end

    cards[:cards].delete_if { |card| card.id == id }
  end

  def delete_card(id)
    cards = @cards.find { |hash| hash[:cards].find {|card| card.id == id }}
    cards[:cards].delete_if { |card| card.id == id }
  end

  private

  def load
    @cards.map { |card| Cards.new(**card)}
  end

  def next_id
    @@id = @cards.size + 1
  end

end

