import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Bit extends FlxSprite
{
	public var weight:Float = 0;
	public var initialPos:FlxPoint;

	public function new(X:Float, Y:Float, Weight:Float = 0, Color:FlxColor = FlxColor.BLACK):Void
	{
		super(X, Y);
		makeGraphic(1, 1, Color);
		weight = Weight;
		reset(X, Y);
	}

	override function reset(X:Float, Y:Float):Void
	{
		super.reset(x, y);

		initialPos = FlxPoint.get(X, Y);
	}

	public function snapback():Void
	{
		x = initialPos.x;
		y = initialPos.y;
	}

	public function push(Force:Float):Void {}
}
