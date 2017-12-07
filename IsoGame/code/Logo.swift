import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

class Logo {

	static func getInput() -> [String : Any]{
		var STR =   "to test fd 1 end"
		//STR +=      "to setup-rabbit rt 90 activate-daemon daemon-rabbit-eat end"
		STR +=      " to setup-robot activate-daemon daemon-robot-walk end"
		//STR +=      "to setup-patch set-var age 0 activate-daemon daemon-patch-change end"
		STR +=      " to daemon-robot-walk fd 1 rt 1 end"
		//STR +=      "to daemon-rabbit-eat rt 10 end"
		//STR +=      "to daemon-patch-change set-var grass 5 end"
		let target0:[String:Any] = [
			"type":"robot",
			"id":1,
			"pos":[
				"x":0,
				"y":0
			],
			"angle":0
		]
		let target1:[String:Any] = [
			"type":"robot",
			"id":2,
			"pos":[
				"x":0,
				"y":0
			],
			"angle":0
		]
		let targets:[[String:Any]] = [
			target0,
			target1
		]
		let patches:[[String:Any]] = Array()
		let dictionary = [
			"targets": targets,
			"patches":patches,
			"logo": STR
			] as [String : Any]
		return dictionary
	}
}
