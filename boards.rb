# require "cards"
require_relative "list"
require "json"

class Board
    attr_reader :arr_of_boards

    def initialize(data, list)
        @data = data
        @list_B = list
    end

    def create_board(id_b, name_b, description_b, list_b)
        arr_c = {}
        arr_c[id_b] = {}
        arr_c[name_b] = {}
        arr_c[description_b] = {}
        arr_c[list_b] = {}
        arr_c[list_b] = @list_B
        @data << arr_c
    end

    def updae_board()

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
    { 
        id: 1,
        name: "Extended - CLIn Boards",
        description: "Task management for the last extended",
        lists: [
            {
                title: "pepe",
                members: ["Diego", "Deyvi", "Wences"],
                labels: ["investigate"],
                due_date: "2023-02-19",
            }
        ]
    }
]
lista = List.new
listab = lista.create_list(:casa)

board = Board.new(data_prub, listab)
board.create_board(:id, :name, :description, :list)
puts data_prub
