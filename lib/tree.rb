require_relative 'node.rb'

class Tree
    attr_accessor :root

    def initialize(array)
        @root = build_tree(array.sort.uniq)
    end

    def build_tree(array)
        return nil if array.empty?

        array = array.uniq.sort
        mid_i = array.length / 2
        node = Node.new(array[mid_i])
        node.left = build_tree(array[0...mid_i])
        node.right = build_tree(array[mid_i + 1..-1])
        return node
    end

    def insert (value, cur_node = @root)
        if @root == nil
            @root = Node.new(value)
        end

        if value > cur_node.value
            cur_node.left.nil? ? node.left = Node.new(value) : insert(value, cur_node.left)
        elsif value < cur_node.value
            cur_node.right.nil? ? node.right = Node.new(value) : insert(value, cur_node.right)
        end
    end

    def delete(value, cur_node = @root)
        if @root == nil
           return @root
        end

        if value > cur_node.value
            cur_node.left = delete(value, cur_node.left)
        elsif value < cur_node.value
            cur_node.right = delete(value, cur_node.right)
        else
            return cur_node.rigth if cur_node.left.nil?
            return cur_node.left if cur_node.right.nil?

            succ_parent = cur_node
            succ = succ_parent.right

            while(succ.left != null)
                succ_parent = succ
                succ = succ.left
            end

            cur_node.value = succ.value
            cur_node.right = delete(succ.left.value, cur_node.right)
        end
        return cur_node
    end

    def find(value, cur_node = root)
        if cur_node.value == value
            return cur_node
        end
        
        find(value, cur_node.right) if cur_node.right != null && cur_node.value < value
        find(value, cur_node.left) if cur_node.left != null && cur_node.value > value

        return null
    end

    def level_order(cur_node = @root, visited = Queue.new)
        print "#{cur_node.value} "
        visited.push(cur_node.left) if !cur_node.left.nil?
        visited.push(cur_node.right) if !cur_node.right.nil?
        return if visited.empty?

        level_order(visited.shift, visited)
    end

    def inorder(node = @root)
        return if node.nil?

        print "#{node.value} "
        inorder(node.left)
        inorder(node.right)
    end

    def preorder(node = @root)
        return if node.nil?

        inorder(node.left)
        print "#{node.value} "
        inorder(node.right)
    end

    def postorder(node = @root)
        return if node.nil?

        inorder(node.left)
        inorder(node.right)
        print "#{node.value} "
    end

    def height(node = @root)
        return -1 if node.nil?

        left_height = height(node.left)
        right_height = height(node.right)
        left_height > right_height ? left_height + 1 : right_height + 1
    end

    def depth(node = @root, parent = @root, edges = 0)
        return 0 if node == parent
        return -1 if parent.nil?
    
        if node < parent.data
          edges += 1
          depth(node, parent.left, edges)
        elsif node > parent.data
          edges += 1
          depth(node, parent.right, edges)
        else
          edges
        end
    end

    def balanced?(node = @root)
        return true if node.nil?

        left_height = height(node.left)
        right_height = height(node.right)

        return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

        false
    end

    def rebalance
        @root = build_tree(inorder)
    end
    
    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
    end
end