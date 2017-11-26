
import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeConsumer : JSExport {

	func consume(jsonString:String)
	func ready()

}

