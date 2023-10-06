class Node
    include Comparable
    attr_accessor :value, :left, :right

    def initialize(value = nil, leftt = nil, right = nil)
        @value = value
        @left = left
        @right = right
    end

    # def <=>(other_node)
    #     value <=> other_node.value
    #  end
end