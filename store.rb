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
    save
  end

  def create_list(id,data)
    board = find_board(id)
    board.create_lists(data)
    save
  end

  def delete_board(id)
    @boards.delete_if { |board| board.id == id }
    save
  end

  def update_board(id, data)
    board = find_board(id)
    board.update_board(**data)
    save
  end

  def update_list(id,name,data)
    board = find_board(id)
    board.update_lists(name,data)
    save
  end

  def delete_list(id,name)
    board = find_board(id)
    board.delete_lists(name)
    save
  end

  def create_card(id, name_list,data)
    board = find_board(id)
    board.create_cards(name_list,data)
    save
  end

  def update_card(board_id,id,name_list,data)
    board = find_board(board_id)
    board.update_cards(id.to_i,name_list,data)
    save
  end

  def delete_card(board_id,id)
    board = find_board(board_id)
    board.delete_cards(id)
    save
  end

  def checklist_card(board_id,card_id)
    board = find_board(board_id)
    board.checklist_card(card_id)
    save
  end

  def add_checklist(board_id,card_id,title)
    board = find_board(board_id)
    board.add_checklists(card_id,title)
    save
  end

  def toggle_checklist(board_id,card_id,index)
    board = find_board(board_id)
    board.toggle_checklists(card_id,index)
    save
  end

  def delete_checklist(board_id,card_id,index)
    board = find_board(board_id)
    board.delete_checklists(card_id,index)
    save
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
    board.lists.each do |lista|
      table = Terminal::Table.new
      table.title = lista.name
      table.headings = ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"]
      table.rows = lista.cards.map(&:cards_table_row)
      puts table
    end
  end
        
  def load
    board_data = JSON.parse(File.read(@filename), symbolize_names: true )
    board_data.map { |list| Board.new(**list)}
  end

          
  def save
    File.write(@filename, @boards.to_json)
  end
end