# Based on http://en.wikipedia.org/wiki/Dijkstra's_algorithm.
class DijkstraAlgorithm
  INFINITY = 1 << 64


  class Path < Struct.new(:nodes, :distance)
  end


  def initialize(graph)
    @graph = graph
  end


  def shortest_path(source_node, destination_node)
    last_step = destination_node
    nodes     = [ last_step ]

    dijkstra(source_node)

    while last_step != -1
      last_step = @predecessors[last_step]
      nodes.unshift(last_step) if last_step != -1
    end

    Path.new(nodes, @distances[destination_node])
  end


  private

  def dijkstra(source_node)
    @distances    = {}
    @predecessors = {}

    @graph.nodes.each do |node|
      @distances[node]    = INFINITY
      @predecessors[node] = -1
    end

    @distances[source_node] = 0
    all_nodes               = @graph.nodes.compact

    while all_nodes.any?
      closest_node = nil
      all_nodes.each do |node|
        if closest_node.nil? || (@distances[node] && @distances[node] < @distances[closest_node])
          closest_node = node
        end
      end

      break if @distances[closest_node] == INFINITY
      all_nodes.delete(closest_node)

      @graph.children_of(closest_node).each do |node|
        distance = @distances[closest_node] + @graph.weights[closest_node][node]
        if distance < @distances[node]
          @distances[node]    = distance
          @predecessors[node] = closest_node
        end
      end
    end
  end
end
