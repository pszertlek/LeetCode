//
//  Dijkstra.swift
//  LeetCode
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 Pszertlek. All rights reserved.
//

import Foundation

public class Vertex: Hashable, Equatable{
    public var identifier: String
    public var neighbors: [(Vertex, Double)] = []
    public var pathLengthFromStart = Double.infinity
    public var pathVerticesFromStart: [Vertex] = []
    
    public init(identifier: String) {
        self.identifier = identifier
    }
    
    public func clearCache() {
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
    }
    
    open var hashValue: Int {
        return identifier.hashValue
    }
    
    
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public class Dijkstra {
    private var totalVertices: Set<Vertex>
    
    public init(vertices: Set<Vertex>) {
        totalVertices = vertices
    }
    
    private func clearCache() {
        totalVertices.forEach { $0.clearCache() }
    }
    
    public func findShortestPaths(from startVertex: Vertex) {
        clearCache()
//        var heap = Heap<Vertex>(array:Array<Vertex>.init(totalVertices), sort: { return $0.pathLengthFromStart > $1.pathLengthFromStart})
        
        var currentVertex: Vertex? = startVertex
        var currentVertices = totalVertices
        while let vertex = currentVertex {
            currentVertices.remove(vertex)
//            heap.remove()
            let filterNeighbors = vertex.neighbors.filter { (v) -> Bool in
                return currentVertices.contains(v.0)
            }
            for v in filterNeighbors {
                let weight = v.1
                let neighborVertex = v.0
                
                neighborVertex.pathLengthFromStart = weight + vertex.pathLengthFromStart
                neighborVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
                vertex.pathVerticesFromStart.append(neighborVertex)
            }
//            heap.reset()
            if currentVertices.isEmpty {
                currentVertex = nil
            }
            
            currentVertex = currentVertices.min(by: { (first, second) -> Bool in
                return first.pathLengthFromStart < second.pathLengthFromStart
            })
//            currentVertex = heap.peek()
        }
        
    }
}

public func findShortestPaths(from startVertex: Vertex) {
    
}
