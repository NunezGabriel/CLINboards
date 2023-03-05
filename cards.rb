class Cards
  attr_reader :id
  attr_accessor :title, :members, :labels, :due_date

  @@id_count = 0

  def initialize(title:, members:, due_date:, labels: nil, id: nil, checklist: [])
    @id =  next_id(id)
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = checklist
  end

  def checklist_card
    puts "Card: #{@title}"
    @checklist.each_with_index do |checklist, index|
      if checklist[:completed]
        puts "[x] #{index + 1}. #{checklist[:title]}"
      else
        puts "[ ] #{index + 1}. #{checklist[:title]}"
      end
    end
  end

  def update_card(title: nil, members: nil, labels: nil, due_date: nil)
    @title = title if title && !title.empty?
    @members = members if members && !members.empty?
    @labels = labels if labels && !labels.empty?
    @due_date = due_date if due_date && !due_date.empty?
  end

  def add_checklist(checklist)
    @checklist << { title: checklist, completed: false }
  end

  def toggle_checklist(index)
    toggle_value = @checklist[index - 1][:completed]
    @checklist[index - 1][:completed] = !toggle_value
  end

  def delete_checklist(index)
    @checklist.delete_at(index - 1)
  end

  def cards_table_row
    lists = []

    @checklist.each do |checklist|
      lists << checklist if checklist[:completed]
    end

    lists

    [@id, @title, @members.join(", "), @labels.join(", "), @due_date, "#{lists.size}/#{@checklist.size}"]
  end

  def to_json(_arg)
    JSON.pretty_generate({
                           id: @id,
                           title: @title,
                           members: @members,
                           labels: @labels,
                           due_date: @due_date,
                           checklist: @checklist
                         })
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
end
