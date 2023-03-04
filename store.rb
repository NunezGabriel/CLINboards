require "terminal-table"
require_relative "list"
require_relative "boards"

class Store

  def initialize(filename)
    @filename = filename
    @boards = load
  end

  def find_board(id)
    @boards.find { |board| board.id == id }
  end

  def create_board(data)
    @boards << Board.new(**data)
  end

  def delete_board(id)
    @boards.delete_if { |board| board.id == id }
  end

  def update_board(id, data)
    board = find_board(id)
    board.update_board(**data)
  end

  def boards_table
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ["ID", "Name", "Description", "List(#cards)"]
    table.rows = @boards.map(&:boards_table_row)
    table
  end

  def list_table(id)
    board = find_board(id)
    lista = board.lists
    table = Terminal::Table.new
    table.title = lista.name
    table.headings = ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"]
    array = lista.cards
    table.rows = array.map(&:cards_table_row)

    table
  end
        
  def load
    board_data = JSON.parse(File.read(@filename), symbolize_names: true )
    board_data.map { |list| Board.new(**list)}
  end

          
  def save
    File.write(@filename, JSON.pretty_generate(@boards))
  end
end