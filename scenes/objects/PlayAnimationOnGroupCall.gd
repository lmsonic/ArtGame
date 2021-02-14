extends AnimatedSprite3D

export(String) var animation_name:String = "mad"

func animate():
	play(animation_name)
