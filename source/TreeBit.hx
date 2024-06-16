import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class TreeBit extends Bit
{
	override public function push(Force:Float):Void
	{
		var m:Float = Math.abs(Force) - weight;
		var dir:Int = Std.int(Force / Math.abs(Force));
		if (FlxG.random.bool(FlxG.random.float(0.1, 0.3) * 100) && m > 0)
		{
			if (Math.ceil(m / 2) <= 2)
				x = initialPos.x + (dir * Math.ceil(m / 2));
			else
				x = (initialPos.x + 2) * dir;
		}
		else
			snapback();
	}

	
}
