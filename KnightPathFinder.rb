require_relative 'PolyTreeNode.rb'

class KnightPathFinder
    def self.valid_moves(pos)
        x, y = pos
        moves = [[x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1],
                 [x+1, y+2], [x+1, y-2], [x-1, y+2], [x-1, y-2]]
        moves.select { |pos| pos.all? { |i| i.between?(0, 7) } }
    end

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        move_tree = build_move_tree
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).select do |move| 
            !@considered_positions.include?(move)
        end
        new_moves.each { |move| @considered_positions.push(move) }
    end

    def build_move_tree
        current = nil
        to_build = [@root_node]
        move_tree = [@root_node]
        until to_build.empty?
            current = to_build.shift
            new_move_positions(current.value).each do |move|
                move_tree.push(PolyTreeNode.new(move))
                new_node = move_tree[-1]
                to_build.push(new_node)
                current.add_child(new_node)
                new_node.parent = current
            end
        end
        move_tree
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        path_back = [end_node]
        while path_back[-1].parent != nil
            path_back.push(path_back[-1].parent)
        end
        path_back.reverse
    end
end