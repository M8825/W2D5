require_relative 'item'
require 'byebug'

class List

  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description=false) 
    description ||= ""

    if Item.valid_date?(deadline)
      @items << Item.new(title, deadline, description) 
      return true
    else
      return false
    end
  end

  def size
    return @items.length
  end

  # TODO: double check and make sure it passes tests
  def valid_index?(index)
    return index <= (size - 1) && index >= 0
  end

  def swap(index_1, index_2)
    if valid_index?(index_1) && valid_index?(index_2)
      @items[index_1], @items[index_2] = @items[index_2], @items[index_1] 
      return true
    else
      return false
    end
  end

  def [](index)
    return valid_index?(index) ? @items[index] :nil
  end

  def priority
    return @items[0]
  end

  def print 
      puts "----------------------------------"
      puts "            #{self.label.upcase}             "
      puts "----------------------------------"
      puts "Index | Item            | Deadline"
      puts "----------------------------------"
      @items.each_with_index do |item, i|
          puts "#{i}     | #{item.title}     | #{item.deadline} "
      end
  end

  def print_full_item (idx)
      return false if !valid_index?(idx)

      puts "------------------------------------------"
      puts "#{@items[idx].title}                     #{@items[idx].deadline}"
      puts "#{@items[idx].description}"
      puts "------------------------------------------"
  end

  def print_priority
      puts "------------------------------------------"
      puts "#{priority.title}                     #{priority.deadline}"
      puts "#{priority.description}"
      puts "------------------------------------------"
  end

  def up(index, amount=1)
    if valid_index?(index)
      amount.times do
         swap(index - 1, index) 
         index -= 1

         break if index == 0
      end

      return true 
    else
      return false
    end
  end

  def up(index, amount=1)
    if valid_index?(index)
      amount.times do
         swap(index + 1, index) 
         index += 1

         break if index == size - 1
      end

      return true 
    else
      return false
    end
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end

end