//
//  GameViewController.swift
//  Star
//
//  Created by Janie Clayton-Hasz on 10/29/16.
//  Copyright © 2016 RedQueenCoder. All rights reserved.
//

import UIKit
import Metal
import MetalKit

let MaxBuffers = 3
let ConstantBufferSize = 2048*1024



class GameViewController:UIViewController, MTKViewDelegate {
  
  var device: MTLDevice! = nil
  
  var commandQueue: MTLCommandQueue! = nil
  var pipelineState: MTLRenderPipelineState! = nil
  var vertexBuffer: MTLBuffer! = nil
  var vertexColorBuffer: MTLBuffer! = nil
  
  let inflightSemaphore = DispatchSemaphore(value: MaxBuffers)
  var bufferIndex = 0
  
  // offsets used in animation
  //    var xOffset:[Float] = [ -1.0, 1.0, -1.0 ]
  //    var yOffset:[Float] = [ 1.0, 0.0, -1.0 ]
  //    var xDelta:[Float] = [ 0.002, -0.001, 0.003 ]
  //    var yDelta:[Float] = [ 0.001,  0.002, -0.001 ]
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    device = MTLCreateSystemDefaultDevice()
    guard device != nil else { // Fallback to a blank UIView, an application could also fallback to OpenGL ES here.
      print("Metal is not supported on this device")
      self.view = UIView(frame: self.view.frame)
      return
    }
    
    // setup view properties
    let view = self.view as! MTKView
    view.device = device
    view.delegate = self
    
    loadAssets()
  }
  
  func loadAssets() {
    
    // load any resources required for rendering
    let view = self.view as! MTKView
    commandQueue = device.makeCommandQueue()
    commandQueue.label = "main command queue"
    
    let defaultLibrary = device.newDefaultLibrary()!
    let fragmentProgram = defaultLibrary.makeFunction(name: "passThroughFragment")!
    let vertexProgram = defaultLibrary.makeFunction(name: "passThroughVertex")!
    
    let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
    pipelineStateDescriptor.vertexFunction = vertexProgram
    pipelineStateDescriptor.fragmentFunction = fragmentProgram
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
    pipelineStateDescriptor.sampleCount = view.sampleCount
    
    do {
      try pipelineState = device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
    } catch let error {
      print("Failed to create pipeline state, error \(error)")
    }
    
    let dataSize = vertexData.count * MemoryLayout<Float>.size
    vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: [])
    vertexBuffer.label = "vertices"

    vertexColorBuffer = device.makeBuffer(bytes: vertexColorData, length: dataSize, options: [])
    vertexColorBuffer.label = "colors"
  }
  
  func update() {

    /*
    // vData is pointer to the MTLBuffer's Float data contents
    let offset = vertexData.count * MemoryLayout<Float>.stride
    
    let pData = vertexBuffer.contents()
    let vData = (pData + offset * bufferIndex).bindMemory(to:Float.self, capacity: offset / MemoryLayout<Float>.stride)
    
    // reset the vertices to default before adding animated offsets
    vData.initialize(from: vertexData)
    
     // Animate triangle offsets
     let lastTriVertex = 24
     let vertexSize = 4
     for j in 0..<3 {
     // update the animation offsets
     xOffset[j] += xDelta[j]
     
     if(xOffset[j] >= 1.0 || xOffset[j] <= -1.0) {
     xDelta[j] = -xDelta[j]
     xOffset[j] += xDelta[j]
     }
     
     yOffset[j] += yDelta[j]
     
     if(yOffset[j] >= 1.0 || yOffset[j] <= -1.0) {
     yDelta[j] = -yDelta[j]
     yOffset[j] += yDelta[j]
     }
     
     // Update last triangle position with updated animated offsets
     let pos = lastTriVertex + j*vertexSize
     vData[pos] = xOffset[j]
     vData[pos+1] = yOffset[j]
     }
     */
  }
  
  func draw(in view: MTKView) {
    
    // use semaphore to encode 3 frames ahead
    let _ = inflightSemaphore.wait(timeout: DispatchTime.distantFuture)
    
//    self.update()
    
    let commandBuffer = commandQueue.makeCommandBuffer()
    commandBuffer.label = "Frame command buffer"
    
    // use completion handler to signal the semaphore when this frame is completed allowing the encoding of the next frame to proceed
    // use capture list to avoid any retain cycles if the command buffer gets retained anywhere besides this stack frame
    commandBuffer.addCompletedHandler{ [weak self] commandBuffer in
      if let strongSelf = self {
        strongSelf.inflightSemaphore.signal()
      }
      return
    }
    
    if let renderPassDescriptor = view.currentRenderPassDescriptor, let currentDrawable = view.currentDrawable {
      let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
      renderEncoder.label = "render encoder"
      
      renderEncoder.pushDebugGroup("draw star")
      renderEncoder.setRenderPipelineState(pipelineState)
      
      renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, at: 0)
      renderEncoder.setVertexBuffer(vertexColorBuffer, offset:0 , at: 1)
//      renderEncoder.setCullMode(.back)
      renderEncoder.drawPrimitives(type: .triangle,
                                   vertexStart: 0,
                                   vertexCount: vertexData.count)
      
      renderEncoder.popDebugGroup()
      renderEncoder.endEncoding()
      
      commandBuffer.present(currentDrawable)
    }
    
    // bufferIndex matches the current semaphore controled frame index to ensure writing occurs at the correct region in the vertex buffer
    bufferIndex = (bufferIndex + 1) % MaxBuffers
    
    commandBuffer.commit()
  }
  
  
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
}
