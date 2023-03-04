require_relative "clin_boards"
require_relative "list"
require "json"


class Board
    attr_reader :id, :lists, :name

    @@id_count = 0
    def initialize(id:nil,name:,description:, lists: [])
        @id = next_id(id)
        @name = name
        @description = description
        @lists = load(lists)
       # @list_B = list
       # @id_key = :id
    end

    def create_lists(data)
        @lists << List.new(**data)
    end

        
    def update_lists(name, data)
        @lists.find do |hash|
        if hash.name == name
            hash.name = data[:name]
        end
        end
    end

    def create_cards(name_list,data)
        lista = @lists.find { |list| list.name == name_list }
        lista.create_new_card(name_list,data)
    end

    def update_cards(id,name_list,data)
        card = @lists.find{ |list| list.cards.find { |card| card.id == id }}
        card_update = card.update_actual_card(id,name_list,data)

        @lists.each do |lista|
            if lista.name != name_list
              new_lista = @lists.find { |lista| lista.name == name_list }
              new_lista.cards.concat(card_update)
              break
            end
        end
      
        delete_data = @lists.find do |list| 
            list.cards.find { |card| card.id == id } && list.name != name_list
        end

        delete_data.cards.delete_if{|card| card.id == id}

    end

    def delete_cards(id)
        delete_data = @lists.find do |list| 
            list.cards.find { |card| card.id == id }
        end
        delete_data.cards.delete_if{|card| card.id == id}
    end

    def checklist_card(id)
        lista = @lists.find{ |list| list.cards.find { |card| card.id == id }}
        card = lista.cards.find {|card| card.id == id}
        card.checklist_card
    end

    def add_checklists(id,title)
        lista = @lists.find{ |list| list.cards.find { |card| card.id == id }}
        card = lista.cards.find {|card| card.id == id}
        card.add_checklist(title)
    end

    def toggle_checklists(id,index)
        lista = @lists.find{ |list| list.cards.find { |card| card.id == id }}
        card = lista.cards.find {|card| card.id == id}
        card.toggle_checklist(index)
    end

    def delete_checklists(id,index)
        lista = @lists.find{ |list| list.cards.find { |card| card.id == id }}
        card = lista.cards.find {|card| card.id == id}
        card.delete_checklist(index)
    end

    def delete_lists(name)
        @lists.delete_if { |hash| hash.name == name}
    end


    def next_id(id)
        if id
        @@id_count = [@@id_count, id].max
        return id
        else
        @@id_count += 1
        end

        @@id_count
    end

    def update_board(name: , description: )
        @name = name if name && !name.empty?
        @description = description if description && !description.empty?
    end

    def delete_board(id)
        @data.each_with_index do |element, index|
            if index == id-1
              @data.delete_at(index)
            end
        end
    end

    def show
        lista = List.new
        lista.list
    end

    def load(lists)
        lists.map { |list| List.new(**list)}
    end


    def boards_table_row

        lists = []

        @lists.each do |hash|
        lists << "#{hash.name}(#{hash.cards.size})"
        end

        listas = lists.join(", ")

        [@id, @name, @description,listas]
    end

    def to_json(arg)
        {
          id: @id,
          name: @name, 
          description: @description, 
          list: @lists, 
        }.to_json
    end
end