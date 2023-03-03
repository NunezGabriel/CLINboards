# require "cards"
require_relative "list"
require "json"


class Board

    @@id_value = 0
    def initialize(id:,name:,description:,lists: nil)
        @id = id
        @name = name
        @description = description
        @lists = lists
       # @list_B = list
       # @id_key = :id
    end
    { name: name, description: description }
    def create_board(name:, description:, lists: nil)
        @@id_value += 1
        arr_c = {}

        arr_c[@id_key] = {}
        arr_c[@id_key] = @@id_value

        arr_c[name_b] = {}
        arr_c[name_b] = b_name_value

        arr_c[description_b] = {}
        arr_c[description_b] = b_description_value

        arr_c[list_b] = {}
        arr_c[list_b] = @list_B
        @data << arr_c
    end

    def update_board(id, new_name_b , new_description_b )
        @data[id-1][:name] = new_name_b
        @data[id-1][:description] = new_description_b
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

    def load
        @list.map { |list| List.new(**list)}
      end
  
    
    def boards_table_row

        lists = []

        @lists.each do |hash|
        lists << "#{hash[:name]}(#{hash[:cards].size})"
        end

        listas = lists.join(", ")
        
        [@id, @name, @description,listas]
    end
end
