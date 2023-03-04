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

end