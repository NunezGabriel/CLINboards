require_relative "boards"
require_relative "list"
require_relative "cards"
require "terminal-table"

class ClinBoards
  def initialize(filename)
    @filename = filename
    @boards = load
  end

  def start
    
    loop do
      puts welcome()
      puts boards_table
      puts boards_menu()
      puts "exit"
      print "> "

      option, id = gets.chomp.split

      case option
      when "create"
        data = boards_form
        @boards.create_board(data)
      when "show"
        show_boards(id.to_i)
      when "update"
        data = board_form
        @boards.update_board(id.to_i, data)
      when "delete"
        @boards.delete_board(id.to_i)
      when "exit"
        puts "Goodbye!"
        break
      end
    end
  end

  private

  def boards_table
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ["ID", "Name", "Description", "List(#cards)"]
    table.rows = @boards.map(&:boards_table_row)
    table
  end

  def load
    board_data = JSON.parse(File.read(@filename), symbolize_names: true )
    board_data.map { |list| Board.new(**list)}
  end

  def welcome
    puts "####################################"
    puts "#      Welcome to CLIn Boards      #"
    puts "####################################"
  end

  def boards_menu
    "create | show ID | update ID | delete ID "
  end

  def boards_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp

    { name: name, description: description }
  end

  def show_boards(board_id)
    loop do
      dislplay_lists_menus()

      option , id = gets.chomp.split

      case option 
      when "create_list"
        puts list_form()
        @list.create_list(name)
        dislplay_lists_menus()
      when "update-list"
        puts list_form()
        @list.update_list(value)
        dislplay_lists_menus()
      when "delete-list"
        puts list_form()
        @list.delete_list(name)
        dislplay_lists_menus()
      when "create-card"
        puts card_form()
        @list.create_card(value, list_id)
        dislplay_lists_menus()
      when "checklist"
        puts ckeck_list(id)
      when "update-card"
        puts card_form()
        @list.update(id, value, list_id)
        dislplay_lists_menus()
      when "delete-card"
        @list.delete(id)
        dislplay_lists_menus()
      when "back"
        break
      end
    end

    def dislplay_lists_menus
      puts @boards.lists_table
      puts lists_menu()
      puts cards_menu()
      puts "back"
      print "> "
    end


    def list_form
      print "Name: "
      name, value = gets.chomp.split

      { name: name, value: value }
    end
    
    def list_options
      option = []
        @lists.each do |hash|
        option << "#{hash[:name]})"
        end
        options = option.join(" | ")
    end

    def card_form
      print "Select a list:"
      puts "Todo | In Progress | Code Review | Done"
      print "> "
      
      print "Title: "
      title = gets.chomp
      print "Members: "
      members = gets.chomp
      print "Labels: "
      labels = gets.chomp
      print "Due Date: "
      due_date = gets.chomp

      { title: title, members: members, lables: labels, due_date: due_date }
    end
  
  
    def checklist(checklist_id)
      @card.checklist_card
      puts "-------------------------------------"
      puts "Checklist options: add | toggle INDEX | delete INDEX"
      puts "back"
      print "> "
      
      option, ind = gets.chomp
      loop do
        
      case option 
      when "add"
        print "Title: "
        title = gets.chomp
        @card.add_checklist(title)
      when "toggle"
        @card.toggle_checklist(ind)
      when "delete"
        @card.delete_checklist(id)
      when "back"
        break
      end

      end

    end
  
  end

end




# get the command-line arguments if neccesary
