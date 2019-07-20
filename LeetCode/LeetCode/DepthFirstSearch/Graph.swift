//
//  Graph.swift
//  LeetCode
//
//  Created by apple on 2019/2/26.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

open class Edge: Equatable {
    open var neighbor: Node
    
    public init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

public func == (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

public class Node: CustomStringConvertible, Equatable {
    open var neighbors: [Edge]
    
    open fileprivate(set) var label: String
    open var distance: Int?
    open var visited: Bool
    
    public init(label: String) {
        self.label = label
        neighbors = []
        visited = false
    }
    
    open var description: String {
        if let distance = distance {
            return "Node(label: \(label), distance: \(distance)"
        }
        return "Node(label: \(label), distance: infinity"
    }
    
    open var hasDistance: Bool {
        return distance != nil
    }
    
    open func remove(_ edge: Edge) {
//        neighbors.remove(at: neighbors.firstIndex(where: {$0 == edge})!)
    }
}

public func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

open class Graph: CustomStringConvertible, Equatable {
    open fileprivate(set) var nodes: [Node]
    
    public init() {
        self.nodes = []
    }
    
    open func addNode(_ label: String) -> Node {
        let node = Node(label: label)
        nodes.append(node)
        return node
    }
    
    open func addEdge(_ source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
    
    open var description: String {
        var description = ""
        
        for node in nodes {
            if !node.neighbors.isEmpty {
                description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"

            }
        }
        return description
    }
    
    open func findNodeWithLabel(_ label: String) -> Node {
        return nodes.filter({ (node) -> Bool in
            node.label == label
        }).first!
    }
    
    open func duplicate() -> Graph {
        let duplicated = Graph()
        for node in nodes {
            _ = duplicated.addNode(node.label)
        }
        
        for node in nodes {
            for edge in node.neighbors {
                let source = duplicated.findNodeWithLabel(node.label)
                let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
                duplicated.addEdge(source, neighbor: neighbour)
            }
        }
        
        return duplicated
    }
}


public func == (lhs: Graph, rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}

func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var nodesExplored = [source.label]
    for edge in source.neighbors {
        if !edge.neighbor.visited {
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
        }
    }
    return nodesExplored
}
