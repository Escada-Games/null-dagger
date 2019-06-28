#Code shamelessly taken from here: https://gist.github.com/swarnimarun/3d66a961030616fe07d4e6f2e4588250
#However, I added a StaticBody2D and CollisionShape2D creator
tool
extends Node

export(Texture) var texture
export var tileSize = Vector2(16, 16)
export var tiles_to_map = Vector2(0, 0)
export var generate = false
export (bool) var createStaticBody=true
export(Script) var gen_script

func _process(delta):
	if generate:
		generate = false
		if texture != null and get_child_count() < 1:
			var xwidth
			var ywidth
			var own = get_tree().get_edited_scene_root()
			if tiles_to_map == Vector2():
				xwidth = texture.get_size().x / tileSize.x
				ywidth = texture.get_size().y / tileSize.y
			else:
				xwidth = tiles_to_map.x
				ywidth = tiles_to_map.y
			texture.get_data().lock()
			for y in range(0, ywidth):
				for x in range(0, xwidth):
					var pos = Vector2(x,y) * tileSize
					if texture.get_data().get_pixel(pos.x + tileSize.x/2.0, pos.y + tileSize.y/2.0).a < 0.2:
						continue
					var spr = Sprite.new()
					spr.position = pos + Vector2(x,y)
					spr.texture = texture
					spr.region_enabled = true
					spr.region_rect = Rect2(pos, tileSize)
					spr.set_script(gen_script)
					if createStaticBody:
						var sb2d = StaticBody2D.new()
						var cs2d = CollisionShape2D.new()
						cs2d.shape = RectangleShape2D.new()
						cs2d.shape.extents = tileSize/2
						sb2d.add_child(cs2d)
						spr.add_child(sb2d)
					add_child(spr)
					spr.set_owner(own)