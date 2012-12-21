class Graph
  attr_reader :nodes, :weights


  def initialize(options = {})
    # Nodes connections are stored like:
    # { some_node => { another_node => weight, yet_another_node => weight}, another_node => ... }
    @nodes   = []
    @weights = {}
  end


  def add_edge(node, other_node, weight)
    if @weights.has_key?(node)
      @weights[node][other_node] = weight
    else
      @weights[node] = { other_node => weight }
    end

    if @weights.has_key?(other_node)
      @weights[other_node][node] = weight
    else
      @weights[other_node] = { node => weight }
    end

    @nodes << node unless @nodes.include?(node)
    @nodes << other_node unless @nodes.include?(other_node)
  end


  def children_of(node)
    @weights[node].keys
  end


  def shortest_path(source_node, destination_node)
    dijkstra = DijkstraAlgorithm.new(self)
    dijkstra.shortest_path(source_node, destination_node)
  end
end
