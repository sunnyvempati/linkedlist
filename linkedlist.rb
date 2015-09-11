class LinkedListNode
  attr_accessor :value, :next_node

  def initialize(value, next_node=nil)
    @value = value
    @next_node = next_node
  end

end


class Stack
  attr_reader :data

  def initialize
    @data = nil
  end

  def push(element)
    @data = LinkedListNode.new(element, @data)
  end

  def pop
    return_val = @data
    @data = @data.next_node
    return_val
  end
end

def reverse_list(list)
  my_stack = Stack.new

  while list
    my_stack.push(list.value)
    list = list.next_node
  end

  my_stack.pop
end

def reverse_list_mutation(list, previous=nil)
  if list.nil?
    return previous
  else
    next_node = list.next_node
    list.next_node = previous
    reverse_list_mutation(next_node, list)
  end
end

def print_values(list_node)
  print "#{list_node.value} --> "
  if list_node.next_node.nil?
    print "nil\n"
    return
  else
    print_values(list_node.next_node)
  end
end

def is_infinite?(list_node)
  pointer_1 = list_node && list_node.next_node
  pointer_2 = pointer_1 && pointer_1.next_node

  return false if pointer_2.nil? || pointer_1.nil?

  while pointer_1 != pointer_2
    pointer_1 = pointer_1.next_node
    pointer_2 = pointer_2.next_node && pointer_2.next_node.next_node
    return false if pointer_2.nil?
  end

  # mu is the start of the circle loop
  mu = 0
  pointer_1 = list_node
  while pointer_1 != pointer_2
    pointer_1 = pointer_1.next_node
    pointer_2 = pointer_2.next_node
    return false if pointer_2.nil?
    mu += 1
  end

  # lam is the size of the circle
  lam = 1
  pointer_2 = pointer_1.next_node
  while pointer_1 != pointer_2
    pointer_2 = pointer_2.next_node
    lam += 1
  end

  return true if lam && mu
end

node1 = LinkedListNode.new(37)
node2 = LinkedListNode.new(99, node1)
node3 = LinkedListNode.new(12, node2)

print_values(node3)
puts "-------"

revlist = reverse_list(node3)
print_values(revlist)

puts "-------"

rev_list_mutation = reverse_list_mutation(node3)
print_values(rev_list_mutation)

puts "-------"

node1 = LinkedListNode.new(10)
node2 = LinkedListNode.new(20, node1)
node3 = LinkedListNode.new(30, node2)
node4 = LinkedListNode.new(40, node3)
node1.next_node = node4

puts is_infinite?(node4)
