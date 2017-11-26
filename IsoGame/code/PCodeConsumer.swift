
import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeConsumer : JSExport {

	func consume(type:String, data:String)
	func ready()

}

