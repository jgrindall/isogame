
import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

protocol PCodeRunner {
	init()
	func setConsumer(consumer:PCodeConsumer) -> PCodeRunner
	func run(fnName:String, arg:String)
	func run(fnName:String)
	func load(fileName:String) -> PCodeRunner
}

