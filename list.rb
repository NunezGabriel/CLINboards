require_relative "cards"
require "json"

class List
  attr_reader :list
  def initialize()
    @list = []  
  end

  def create_list(value)
    hash = {}
    hash[value] = {}
    @list << hash
  end

#########################################
  #falta revisar este uptate
  def update_list(value)
    list = @list.map do |name|
              if name.keys.include?(:value)
              end
            end
    list[0].transform_keys! { |key| key == "value" ? "newvalue" : key }
  end

  def delete_list(value)
    @list.delete_if{|key, _value| key == value}
  end
#########################################

  def create_card(value)
    newcard = Cards.new(**value)
    @list << newcard
    @list
  end

  def update(id,value)
    card = @list.find { |card| card.id == id }
    card.update_card(**value)
  end
  
  def delete(id)
    @list.delete_if{|card| card.id == id}
  end

  private

  def load
    playlists_data = JSON.parse(File.read("card.json"), symbolize_names: true )
  end
end

lista = List.new()
 data = 
  {
    title: "pepe",
    members: ["Diego", "Deyvi", "Wences"],
    labels: ["investigate"],
    due_date: "2023-02-19",
  }


lista.create_list(:casa)
# p lista.list