
import UIKit
import SpriteKit

class CharacterList  {
	
	private var _chars : [PCharacter]
	
	private var _data:[[Float]] = [[0, 1, 1, 1, 0], [0, 1, 2, 2, 0]]
	
	init(){
		_chars = [PCharacter]()
	}
	
	func setup(){
		for a:[Float] in _data{
			add(a: a)
		}
	}
	
	func updateAtTime(currentTime:TimeInterval){
		_chars.forEach { (char) in
			char.updateAtTime(currentTime:currentTime)
			Projections.posChar(char: char)
		}
	}
	
	func getChars() -> [PCharacter]{
		return _chars
	}
	
	func consume(data:[String:Any]){
		_chars[0].addAnimation(data: data)
	}
	
	func add(a:[Float]){
		_chars.append(Character(id:Int(a[0]), texture:Int(a[1]), x: a[2], y: a[3], rot:a[4]))
	}
	
}
