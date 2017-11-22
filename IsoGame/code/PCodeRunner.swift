//
//  ImageUtils
//  SceneKitTest
//
//  Created by John on 25/06/2016.
//
//

import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeRunner {
	init(fileNames:[String])
	func setConsumer(consumer:PCodeConsumer)
	func run(fnName:String, arg:String)
}

