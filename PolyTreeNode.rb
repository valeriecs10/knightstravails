class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = [] 
    end

    def parent=(new_parent)
        @parent.children.delete(self) unless @parent.nil?
        @parent = new_parent
        @parent.children.push(self) unless @parent.nil?
    end

    def remove_child(child)
        if @children.include?(child)
            child.parent = nil 
        else
            raise "Not a child"
        end
    end

    def add_child(child)
        child.parent = self
    end

    def dfs(target)
        return self if @value == target
        target_node = nil
        @children.each do |child| 
            target_node = child.dfs(target)
            return target_node unless target_node.nil?
        end
        nil
    end

    def bfs(target)
        to_search = [self]
        until to_search.empty?
            current = to_search.shift
            return current if current.value == target
            current.children.each { |child| to_search.push(child) }
        end
    end 

    def inspect
        @value.inspect
    end

    def to_s
        @value
    end
end