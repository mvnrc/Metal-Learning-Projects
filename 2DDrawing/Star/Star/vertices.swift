//
//  vertices.swift
//  Star
//
//  Created by Janie Clayton-Hasz on 10/31/16.
//  Copyright © 2016 RedQueenCoder. All rights reserved.
//

import Foundation

// Need to figure out how to make this into a triangle strip?? Also, I think I need another vertex
let vertexData:[Float] =
    [
        // Internal Triangles
        0.0, 0.0, 0.0, 1.0,
        -0.2, 0.2, 0.0, 1.0,
        0.2, 0.2, 0.0, 1.0,
        
        0.0, 0.0, 0.0, 1.0,
        0.2, 0.2, 0.0, 1.0,
        0.3, 0.0, 0.0, 1.0,
        
        0.0, 0.0, 0.0, 1.0,
        0.3, 0.0, 0.0, 1.0,
        0.0, -0.2, 0.0, 1.0,
        
        0.0, 0.0, 0.0, 1.0,
        0.0, -0.2, 0.0, 1.0,
        -0.3, 0.0, 0.0, 1.0,
        
        0.0, 0.0, 0.0, 1.0,
        -0.3, 0.0, 0.0, 1.0,
        -0.2, 0.2, 0.0, 1.0,
        
        // External Triangles
        0.0, 0.6, 0.0, 1.0,
        -0.2, 0.2, 0.0, 1.0,
        0.2, 0.2, 0.0, 1.0,
        
        0.6, 0.2, 0.0, 1.0,
        0.2, 0.2, 0.0, 1.0,
        0.3, 0.0, 0.0, 1.0,
        
        0.6, -0.4, 0.0, 1.0,
        0.0, -0.2, 0.0, 1.0,
        0.3, 0.0, 0.0, 1.0,
        
        -0.6, -0.4, 0.0, 1.0,
        0.0, -0.2, 0.0, 1.0,
        -0.3, 0.0, 0.0, 1.0,
        
        -0.6, 0.2, 0.0, 1.0,
        -0.2, 0.2, 0.0, 1.0,
        -0.3, 0.0, 0.0, 1.0
]

// Some of these are probably wrong. Will see when I get this to build
let vertexColorData:[Float] =
    [
        // Internal Triangles
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        // External Triangles
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        
        1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0
]
