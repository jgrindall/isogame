
import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeConsumer : JSExport {

	func consume(data:[String:Any])
	func onError()
	func ready()

}

