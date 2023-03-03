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

    def create_board(name_b, description_b, list_b)
        @@id_value += 1
        arr_c = {}
        arr_c[@id_key] = {}
        arr_c[@id_key] = @@id_value
        arr_c[name_b] = {}
        arr_c[description_b] = {}
        arr_c[list_b] = {}
        arr_c[list_b] = @list_B
        @data << arr_c
    end

    def update_board()

    end

    def delete_board()

    end

    def show
        lista = List.new
        lista.list
    end

    def data_prub

    end
end

data_prub = [ 
    # { 
    #     id: 1,
    #     name: "Extended - CLIn Boards",
    #     description: "Task management for the last extended",
    #     lists: [
    #         {
    #             title: "pepe",
    #             members: ["Diego", "Deyvi", "Wences"],
    #             labels: ["investigate"],
    #             due_date: "2023-02-19",
    #         }
    #     ]
    # }
]
lista = List.new
listab = lista.create_list(:casa)

board = Board.new(data_prub, listab)
board.create_board(:name, :description, :list)
board.create_board(:name, :description, :list)
board.create_board(:name, :description, :list)

puts data_prub