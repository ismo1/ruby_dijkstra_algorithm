$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'test/unit'
require 'node'
require 'graph'
require 'dijkstra_algorithm'


class TestDijkstra < Test::Unit::TestCase
  def test_create_node_with_name
    paris = Node.new('Paris')

    assert_equal paris.name, 'Paris'
  end


  def test_node_with_same_names_are_equal
    paris_1 = Node.new('Paris')
    paris_2 = Node.new('Paris')

    assert_equal paris_1, paris_2
  end


  def test_node_with_different_names_are_not_equal
    paris = Node.new('Paris')
    melun = Node.new('Melun')

    assert_not_equal paris, melun
  end


  def test_create_bilateral_edge
    graph = Graph.new
    paris = Node.new('Paris')
    melun = Node.new('Melun')

    graph.add_edge(paris, melun, 40)

    assert_equal graph.children_of(paris), [ melun ]
    assert_equal graph.children_of(melun), [ paris ]
    assert_equal graph.nodes, [ paris, melun ]
  end


  def test_dijkstra_algorithm
    graph       = Graph.new
    arras       = Node.new('Arras')
    bordeaux    = Node.new('Bordeaux')
    brest       = Node.new('Brest')
    lyon        = Node.new('Lyon')
    marseille   = Node.new('Marseille')
    montpellier = Node.new('Montpellier')
    nantes      = Node.new('Nantes')
    paris       = Node.new('Paris')
    poitiers    = Node.new('Poitiers')
    strasbourg  = Node.new('Strasbourg')

    graph.add_edge(arras, strasbourg, 522)
    graph.add_edge(arras, paris, 185)
    graph.add_edge(arras, nantes, 561)

    graph.add_edge(bordeaux, nantes, 334)
    graph.add_edge(bordeaux, poitiers, 237)

    graph.add_edge(brest, nantes, 298)
    graph.add_edge(brest, paris, 593)

    graph.add_edge(lyon, paris, 465)
    graph.add_edge(lyon, strasbourg, 494)
    graph.add_edge(lyon, marseille, 315)
    graph.add_edge(lyon, montpellier, 303)

    graph.add_edge(marseille, strasbourg, 809)
    graph.add_edge(marseille, lyon, 315)
    graph.add_edge(marseille, montpellier, 171)

    graph.add_edge(montpellier, poitiers, 557)
    graph.add_edge(montpellier, lyon, 303)
    graph.add_edge(montpellier, strasbourg, 797)
    graph.add_edge(montpellier, marseille, 171)

    graph.add_edge(nantes, arras, 561)
    graph.add_edge(nantes, paris, 386)
    graph.add_edge(nantes, bordeaux, 334)
    graph.add_edge(nantes, brest, 298)

    graph.add_edge(paris, brest, 593)
    graph.add_edge(paris, nantes, 386)
    graph.add_edge(paris, arras, 185)
    graph.add_edge(paris, lyon, 465)
    graph.add_edge(paris, poitiers, 338)

    graph.add_edge(poitiers, paris, 338)
    graph.add_edge(poitiers, montpellier, 557)
    graph.add_edge(poitiers, bordeaux, 237)

    graph.add_edge(strasbourg, arras, 522)
    graph.add_edge(strasbourg, lyon, 494)
    graph.add_edge(strasbourg, montpellier, 797)
    graph.add_edge(strasbourg, marseille, 809)

    path = graph.shortest_path(bordeaux, strasbourg)
    assert_equal [ bordeaux, poitiers, paris, arras, strasbourg ], path.nodes
    assert_equal 1282, path.distance
  end
end
