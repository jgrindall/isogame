
import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeRunner {
	init(fileName:String)
	func setConsumer(consumer:PCodeConsumer) -> PCodeRunner
	func run(fnName:String, arg:String)
	func load()
}

