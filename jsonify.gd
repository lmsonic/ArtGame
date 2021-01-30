class_name Jsonify

static func jsonify(data):
	
	match typeof(data):
		
		TYPE_STRING, \
		TYPE_BOOL, \
		TYPE_INT, \
		TYPE_REAL:
			return data
		
		TYPE_ARRAY:
			for i in len(data):
				data[i] = jsonify(data[i])
			return data
		
		TYPE_DICTIONARY:
			for k in data:
				data[k] = jsonify(data[k])
			return data
		
		TYPE_VECTOR2:
			return {
				"x": data.x,
				"y": data.y
			}

		TYPE_COLOR:
			return {
				"r": data.r,
				"g": data.g,
				"b": data.b,
				"a": data.a
			}

		TYPE_RECT2:
			return {
				"x": data.position.x,
				"y": data.position.y,
				"w": data.size.x,
				"h": data.size.y
			}

		TYPE_VECTOR3:
			return {
				"x": data.x,
				"y": data.y,
				"z": data.z
			}
		TYPE_OBJECT:
			match(data.get_class()):
				Point:
					return{
						"X":data.X,
						"Y":data.Y,
						"StrokeID":data.StrokeID
					}
				Line:
					return{
						"start": jsonify(data.start),
						"end": jsonify(data.end),
						"width": data.width,
						"color": jsonify(data.color)
					}
		_:
			# Unhandled data type
			printerr("Unhandled data: ", data)
			assert(false)


static func godotify(data):

	match typeof(data):
		
		TYPE_ARRAY:
			for i in len(data):
				data[i] = godotify(data[i])
			return data
		
		TYPE_DICTIONARY:
			
			match len(data):
				2:
					if data.has("x") and data.has("y"):
						return Vector2(data.x, data.y)
				3:
					if data.has("x") and data.has("y") and data.has("z"):
						return Vector3(data.x, data.y, data.z)
				4:
					if data.has("r") and data.has("g") and data.has("b") and data.has("a"):
						return Color(data.r, data.g, data.b, data.a)
					
					elif data.has("x") and data.has("y") and data.has("w") and data.has("h"):
						return Rect2(data.x, data.y, data.w, data.h)
			
			for k in data:
				data[k] = godotify(data[k])
			return data
		TYPE_OBJECT:
			match(data.get_class()):
				Point:
					return Point.new(data.X,data.Y,data.StrokeID)
					
				Line:
					return Line.new(godotify(data.start),godotify(data.end),data.width,godotify(data.color))
					
		_:
			return data
