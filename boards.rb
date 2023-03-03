# require "cards"
require_relative "list"
require "json"

class Board

    @@id_value = 0
    def initialize(data, list)
        @data = data
        @list_B = list
        @id_key = :id
    end

    def create_board(name_b, description_b, list_b, b_name_value = "unknow", b_description_value = "unknow" )
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

    def data_prub

    end
end

data_prub = [ 
    { 
        id: 1,
        name: "Extended - CLIn Boards",
        description: "Task management for the last extended",
        lists: [
            {
                id: 1,
                name: "alberto",
                cards: []
            }
        ]
    }
]
# ============================= PRUEBAS =================================
# lista = List.new
# lista_br = lista.create_list("casa")

# board = Board.new(data_prub, lista_br)
# board.create_board(:name, :description, :list)
# board.create_board(:name, :description, :list)
# board.create_board(:name, :description, :list)
# puts data_prub
# p "==============================="
# board.delete_board(2)
# puts data_prub
# p "==============================="
# board.update_board(1,"juan","esta es otra descripcion")
# puts data_prub