import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Wisp extends FlxSprite
{
	private var fading:Bool = false;

	public function new(X:Int, Y:Int):Void
	{
		super(X, Y);
		makeGraphic(1, 1, FlxColor.WHITE);
		reset(X, Y);
	}

	override function reset(x:Float, y:Float)
	{
		super.reset(x, y);
		alpha = FlxG.random.float(0.1, 0.6);
		fading = false;
	}

	override public function update(elapsed:Float):Void
	{
		if (!alive || !exists)
			return;

		if (fading)
		{
			if (alpha <= 0)
			{
				alive = exists = false;
				return;
			}
			else
				alpha -= 0.2 * elapsed;
		}
		else if (Math.abs(Globals.PlayState.wind) > 3)
		{
			kill();
		}
		else
		{
			if ((Globals.PlayState.wind > 0 && x > FlxG.width) || (Globals.PlayState.wind < 0 && x < 0) || y < 0)
			{
				kill();
			}
		}
		velocity.x = Globals.PlayState.wind * 20 * FlxG.random.float(0.75, 1.25);
		velocity.y = Globals.PlayState.wind * 0.05 * FlxG.random.float(-0.25, 0.25);
		super.update(elapsed);
	}

	override function kill()
	{
		fading = true;
	}
}
