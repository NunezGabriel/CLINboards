require_relative "boards"
require_relative "list"
require_relative "cards"
require_relative "store"


class ClinBoards
  def initialize(filename)
    @filename = filename
    @store = Store.new(filename)
  end

  def start
    
    loop do
      puts welcome()
      puts @store.boards_table
      puts boards_menu()
      puts "exit"
      print "> "

      option, id = gets.chomp.split

      case option
      when "create"
        data = boards_form
        @store.create_board(data)
      when "show"
        show_boards(id.to_i)
      when "update"
        data = boards_form
        @store.update_board(id.to_i, data)
      when "delete"
        @store.delete_board(id.to_i)
      when "exit"
        puts "Goodbye!"
        break
      end
    end
  end

  private


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
      @store.list_table(board_id)
      dislplay_lists_menus()

      option , id = gets.chomp.split

      case option 
      when "create-list"
        data = list_form
        @store.create_list(board_id,data)
        dislplay_lists_menus()
      when "update-list"
        data = list_form
        @store.update_list(board_id,id,data)
        dislplay_lists_menus()
      when "delete-list"
        @store.delete_list(board_id,id)
        dislplay_lists_menus()
      when "create-card"
        name_list = card_list_form
        data = card_form
        @store.create_card(board_id, name_list,data)
        dislplay_lists_menus()
      when "checklist"
        puts ckeck_list(id)
      when "update-card"
        name_list = card_list_form
        data = card_form
        @store.update_card(board_id,id.to_i,name_list,data)
        dislplay_lists_menus()
      when "delete-card"
        @store.delete_card(board_id,id.to_i)
        dislplay_lists_menus()
      when "back"
        break
      end
    end

    
    def list_options
      option = []
        @lists.each do |hash|
        option << "#{hash[:name]})"
        end
        options = option.join(" | ")
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

  def dislplay_lists_menus
    puts "List options: create-list | update-list LISTNAME | delete-list LISTNAME"
    puts "Card options: create-card | checklist ID | update-card ID | delete-card ID"
    puts "back"
    print "> "
  end

  def list_form
    print "Name: "
    name= gets.chomp

    { name: name }
  end

  def card_list_form
    print "Select a list:"
    puts " Todo | In Progress | Code Review | Done"
    print "> "
    list = gets.chomp
  end

  def card_form
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp.split(",")
    print "Labels: "
    labels = gets.chomp.split(",")
    print "Due Date: "
    due_date = gets.chomp

    { title: title, members: members, labels: labels, due_date: due_date }
  end

end




# get the command-line arguments if neccesary
