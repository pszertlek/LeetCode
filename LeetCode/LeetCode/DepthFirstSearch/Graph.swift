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

class BFSSolution {
    func landderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var allComboDict = [String: [String]]()
        wordList.forEach { (word) in
            let start = word.startIndex
            let end = word.endIndex
            var i = start
            
            while i < end {
                let newword = String(word[start..<i] + "*" + word[word.index(after: i)..<end])
                allComboDict[newword, default: []].append(word)
                i = word.index(after: i)
            }
        }
        var queue = [(String,Int)]()
        queue.append((beginWord,1))
        var visited = [String: Bool]()
        visited[beginWord] = true
        while !queue.isEmpty {
            let node = queue.removeLast()
            let word = node.0
            let level = node.1
            let start = word.startIndex
            let end = word.endIndex
            var i = start
            while i < end {
                let newword = String(word[start..<i] + "*" + word[word.index(after: i)..<end])
                for adjacentWord in allComboDict[newword, default:[]] {
                    if adjacentWord == endWord {
                        return level + 1
                    }
                    if nil == visited[adjacentWord] {
                        visited[adjacentWord] = true
                        queue.append((adjacentWord, level + 1))
                    }
                }
                i = word.index(after: i)
            }
        }
        return 0
    }
    
    class Node {
        var val: Int
        var neighbors: [Node?]
        init(_ val: Int, _ neighbors: [Node] = []) {
            self.val = val
            self.neighbors = neighbors
        }
    }
    
    func clone(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        var queue: [(Node?,[Node?])] = [(nil,[node])]
        var res: Node?
        var dict: [Int: Node] = [:]
        var visited = Set<Int>()
        while queue.count > 0 {
            var newQueue = [(Node?, [Node?])]()
            while let pair = queue.popLast() {
                let pre = pair.0
                if let i = pre?.val {
                    if visited.contains(i) {
                        continue
                    } else {
                        visited.insert(i)
                    }
                }
                for n in pair.1  {
                    var newNode: Node!
                    if let theNode = dict[n!.val] {
                        newNode = theNode
                    } else {
                        newNode = Node(n!.val)
                        dict[n!.val] = newNode
                    }
                    if res == nil {
                        res = newNode
                    }
                    newQueue.append((newNode,n!.neighbors))
                    pre?.neighbors.append(newNode)
                }


            }
            queue = newQueue
        }
        return res
    }
    
    public func singleNumber(_ nums: [Int]) -> Int {
        var seenOnce = 0, seenTwice = 0
        for num in nums {
            seenOnce = ~seenTwice & (seenOnce ^ num)
            seenTwice = ~seenOnce & (seenTwice ^ num)
        }
        return seenOnce
    }
}
