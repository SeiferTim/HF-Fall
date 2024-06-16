import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;

class LeafBit extends Bit
{
	public static var COLORS:Array<FlxColor> = [0xffb14211, 0xffd9541a, 0xff663408, 0xffbc5815, 0xffecb338, 0xffbf1313];

	public var falling:Bool = false;
	public var landed:Bool = false;

	public function new(X:Float, Y:Float, Weight:Float = 0):Void
	{
		super(X, Y, Weight, COLORS[FlxG.random.int(0, COLORS.length - 1)]);
	}

	override function update(elapsed:Float)
	{
		if (!alive || !exists)
			return;
		if (y > FlxG.height || x < -100 || x > FlxG.width + 100)
		{
			kill();
			return;
		}
		super.update(elapsed);
	}

	override function reset(X:Float, Y:Float)
	{
		super.reset(X, Y);
		solid = false;
	}

	override public function push(Force:Float):Void
	{
		var m:Float = Math.ceil((Math.abs(Force) - weight) / 2);
		var dir:Int = Std.int(Force / Math.abs(Force));
		if (landed)
		{
			acceleration.y = weight * 15;
			if (x > -50 && x < FlxG.width + 50)
			{
				velocity.x = ((dir * m) * FlxG.random.float(0.65, 0.95));
				if (m > 2)
				{
					if (FlxG.random.bool(1))
					{
						velocity.y = -(m * FlxG.random.float(0.5, 0.75));
						falling = true;
						landed = false;
					}
				}
			}
		}
		else if (!falling)
		{
			if (FlxG.random.bool(FlxG.random.float(0.1, 0.3) * 100) && m > 0)
			{
				if (m > 2)
				{
					if (FlxG.random.bool(1))
					{
						falling = true;
						solid = true;
					}
					else
					{
						x = initialPos.x + (dir * 2);
					}
				}
				else
				{
					x = initialPos.x + (dir * m);
				}
			}
			else
				snapback();
		}
		else
		{
			acceleration.y = weight * 5;

			velocity.x = ((dir * m) * FlxG.random.float(0.85, 1.15)) + FlxG.random.int(-2, 2);
			velocity.y = ((m * 0.5) * FlxG.random.float(-.15, .15)) * FlxG.random.sign(30);
		}
	}

	public function hitCheck(Contact:FlxObject):Bool
	{
		var hit:Bool = true;
		if (Contact is LeafBit)
		{
			hit = cast(Contact, LeafBit).landed;
		}
		if (hit)
		{
			solid = true;
			velocity.set();
			falling = false;
			landed = true;
		}
		return hit;
	}
}
