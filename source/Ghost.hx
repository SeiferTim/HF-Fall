import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class Ghost extends FlxSpriteGroup
{
	public var parts:Map<String, FlxSprite> = [];
	public var fading:Bool = false;
	public var timer:Float = 0;

	public function new(X:Float, Y:Float):Void
	{
		super();

		parts.set("0,0", add(new FlxSprite(0, 0).makeGraphic(5, 1, FlxColor.WHITE)));
		parts.set("0,1", add(new FlxSprite(0, 1).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("2,1", add(new FlxSprite(2, 1).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("4,1", add(new FlxSprite(4, 1).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("0,2", add(new FlxSprite(0, 2).makeGraphic(5, 1, FlxColor.WHITE)));
		parts.set("0,3", add(new FlxSprite(0, 3).makeGraphic(2, 1, FlxColor.WHITE)));
		parts.set("3,3", add(new FlxSprite(3, 3).makeGraphic(2, 1, FlxColor.WHITE)));
		parts.set("0,4", add(new FlxSprite(0, 4).makeGraphic(2, 1, FlxColor.WHITE)));
		parts.set("3,4", add(new FlxSprite(3, 4).makeGraphic(2, 1, FlxColor.WHITE)));
		parts.set("0,5", add(new FlxSprite(0, 5).makeGraphic(5, 1, FlxColor.WHITE)));
		parts.set("0,6", add(new FlxSprite(0, 6).makeGraphic(5, 1, FlxColor.WHITE)));
		parts.set("0,7", add(new FlxSprite(0, 7).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("2,7", add(new FlxSprite(2, 7).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("4,7", add(new FlxSprite(4, 7).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("0,8", add(new FlxSprite(0, 8).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("2,8", add(new FlxSprite(2, 8).makeGraphic(1, 1, FlxColor.WHITE)));
		parts.set("4,8", add(new FlxSprite(4, 8).makeGraphic(1, 1, FlxColor.WHITE)));

		reset(X, Y);
	}

	override public function reset(X:Float, Y:Float):Void
	{
		super.reset(X, Y);

		fading = false;
		timer = 0;
		alive = exists = true;

		for (key in parts.keys())
		{
			// var pos:Array<String> = key.split(",");
			var part:FlxSprite = parts.get(key);

			// part.reset(x + Std.parseInt(pos[0]), y + Std.parseInt(pos[1]));
			part.alpha = 0.1;
			part.blend = openfl.display.BlendMode.OVERLAY;
		}

		velocity.set(FlxG.random.float(-20, 20), -FlxG.random.float(24, 32));
	}

	override public function update(elapsed:Float):Void
	{
		if (!alive || !exists)
			return;

		if (fading)
		{
			if (timer <= 0)
			{
				if (parts.get("0,0").alpha <= 0)
				{
					kill();
					return;
				}
				else
				{
					for (key in parts.keys())
					{
						var pos:Array<String> = key.split(",");
						var part:FlxSprite = parts.get(key);
						part.alpha -= (0.1 * elapsed) - (Std.parseInt(pos[1]));
					}
				}
			}
			else
				timer -= FlxG.elapsed;
		}
		else
		{
			if (parts.get("0,0").alpha >= 1)
			{
				fading = true;
				timer = FlxG.elapsed * 3.5;
			}
			else
			{
				for (key in parts.keys())
				{
					var pos:Array<String> = key.split(",");
					var part:FlxSprite = parts.get(key);
					part.alpha += (0.15 * elapsed) - (Std.parseInt(pos[1]));
				}
			}
		}

		super.update(elapsed);
	}
}
