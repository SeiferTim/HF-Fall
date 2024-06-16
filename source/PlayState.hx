package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxGradient;

class PlayState extends FlxState
{
	public static inline var VERSION:String = "3.0.0";

	public var CrazyMode:Bool = false;

	public static inline var WIND_MAX:Float = 10;
	public static inline var CRAZY_WIND_MAX:Float = 15;

	// ORANGE: #FB9202
	// PURPLE: 	#2B003D
	// BLACK: #15001E
	public var timer:Float = 0;
	public var mistDir:Float = -1;
	public var wind:Float = 0.0;
	public var goal:Float = 0;

	private var sky:FlxSprite;
	private var ground:FlxSprite;
	private var crazy:FlxSprite;
	private var mist:FlxSprite;

	private var tree:FlxTypedGroup<TreeBit>;
	private var leaves:FlxTypedGroup<LeafBit>;

	private var wispBackGroup:FlxTypedGroup<Wisp>;
	private var wispFrontGroup:FlxTypedGroup<Wisp>;
	private var ghostBackGroup:FlxTypedGroup<Ghost>;
	private var ghostFrontGroup:FlxTypedGroup<Ghost>;
	private var jackGroup:FlxGroup;

	public function new():Void
	{
		super();
		Globals.PlayState = this;
	}

	override public function create()
	{
		sky = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xff15001E, 0xff2B003D, 0xffFB9202], 1, 90);

		wispBackGroup = new FlxTypedGroup<Wisp>();
		wispFrontGroup = new FlxTypedGroup<Wisp>();

		ghostBackGroup = new FlxTypedGroup<Ghost>();
		ghostFrontGroup = new FlxTypedGroup<Ghost>();

		buildTree();
		buildLeaves();
		addDebris();

		jackGroup = new FlxGroup();

		crazy = new FlxSprite(0, 0, "assets/images/crazy.png");
		crazy.alpha = 0;
		crazy.blend = openfl.display.BlendMode.SCREEN;

		mist = new FlxSprite(0, 0, "assets/images/mist.png");
		mist.alpha = .88;
		mist.blend = openfl.display.BlendMode.OVERLAY;

		ground = new FlxSprite(-50, FlxG.height - 5);
		ground.makeGraphic(FlxG.width + 100, 5, 0xff000000);
		ground.moves = false;
		ground.immovable = true;

		add(sky);
		add(wispBackGroup);
		add(ghostBackGroup);
		add(tree);
		add(jackGroup);
		add(leaves);
		add(wispFrontGroup);
		add(ghostFrontGroup);
		add(crazy);
		add(mist);
		add(ground);

		wind = FlxG.random.float(-WIND_MAX, WIND_MAX);
		goal = FlxG.random.float(-WIND_MAX, WIND_MAX);

		super.create();
	}

	private function addDebris():Void
	{
		for (tY in 6...9)
		{
			for (tX in -50...Std.int(FlxG.width + 50))
			{
				if (FlxG.random.bool(80))
				{
					var l:LeafBit = leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
					l.solid = l.falling = true;
					l.landed = false;
				}
			}
		}
	}

	private function buildTree():Void
	{
		tree = new FlxTypedGroup<TreeBit>();

		for (tY in 6...26)
		{
			for (tX in -2...2)
			{
				tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, 50));
			}
		}

		for (tY in 20...25)
		{
			for (tX in -10...10)
			{
				if (FlxG.random.bool(FlxG.random.float(0.2, 0.4) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(4, 6)));
				}
			}
		}

		for (tY in 25...36)
		{
			for (tX in -6...6)
			{
				if (FlxG.random.bool(FlxG.random.float(0.5, 0.7) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(6, 8)));
				}
			}
		}

		for (tY in 23...36)
		{
			for (tX in -18...-6)
			{
				if (FlxG.random.bool(FlxG.random.float(0.1, 0.4) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(4, 6)));
				}
			}
		}

		for (tY in 23...36)
		{
			for (tX in 6...18)
			{
				if (FlxG.random.bool(FlxG.random.float(0.1, 0.4) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(4, 6)));
				}
			}
		}

		for (tY in 36...47)
		{
			for (tX in -14...14)
			{
				if (FlxG.random.bool(FlxG.random.float(0.2, 0.6) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(3, 5)));
				}
			}
		}

		for (tY in 47...52)
		{
			for (tX in -8...8)
			{
				if (FlxG.random.bool(FlxG.random.float(0.1, 0.3) * 100))
				{
					tree.add(new TreeBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(2, 4)));
				}
			}
		}
	}

	private function buildLeaves():Void
	{
		leaves = new FlxTypedGroup<LeafBit>();

		for (tY in 18...25)
		{
			for (tX in -12...12)
			{
				if (FlxG.random.bool(FlxG.random.float(0.3, 0.5) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}

		for (tY in 25...36)
		{
			for (tX in -6...6)
			{
				if (FlxG.random.bool(FlxG.random.float(0.6, 0.8) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}

		for (tY in 21...38)
		{
			for (tX in -20...-6)
			{
				if (FlxG.random.bool(FlxG.random.float(0.2, 0.5) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}

		for (tY in 21...38)
		{
			for (tX in 6...20)
			{
				if (FlxG.random.bool(FlxG.random.float(0.2, 0.5) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}

		for (tY in 36...47)
		{
			for (tX in -16...16)
			{
				if (FlxG.random.bool(FlxG.random.float(0.3, 0.7) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}

		for (tY in 47...54)
		{
			for (tX in -10...10)
			{
				if (FlxG.random.bool(FlxG.random.float(0.2, 0.4) * 100))
				{
					leaves.add(new LeafBit((FlxG.width / 2) + tX, FlxG.height - tY, FlxG.random.int(1, 2)));
				}
			}
		}
	}

	override public function update(elapsed:Float)
	{
		if (timer <= 0)
		{
			wind += FlxG.random.float(1, 3) * (goal / Math.abs(goal));
			timer = 0.2;

			for (t in tree)
				t.push(wind);
			for (l in leaves)
				l.push(wind);
			if (CrazyMode && crazy.alpha < 0.66)
				crazy.alpha += 0.11 * elapsed;
			else if (!CrazyMode && crazy.alpha > 0)
				crazy.alpha -= 0.11 * elapsed;
		}
		else
			timer -= elapsed;
		if (Math.abs(wind) >= Math.abs(goal))
		{
			if (CrazyMode)
				goal = FlxG.random.float(-CRAZY_WIND_MAX, CRAZY_WIND_MAX);
			else
				goal = FlxG.random.float(-WIND_MAX, WIND_MAX);
		}
		mist.velocity.x = wind;
		if (mist.x <= -500 + FlxG.width)
			mist.x = -500 + FlxG.width;
		else if (mist.x > 0)
			mist.x = 0;

		FlxG.collide(leaves, leaves, leavesHit);
		FlxG.collide(ground, leaves, groundHit);
		FlxG.collide(ground, jackGroup, jackBounce);
		// FlxG.overlap(jackGroup, leaves, leafSplat);

		randomSpawns();

		super.update(elapsed);
	}

	private function randomSpawns():Void
	{
		if (FlxG.random.bool(2.5) || (CrazyMode && FlxG.random.bool(50)))
			spawnLeaf();
		if (FlxG.random.bool(5) || (CrazyMode && FlxG.random.bool(10)))
			spawnWisp(true);

		if (FlxG.random.bool(0.5) || (CrazyMode && FlxG.random.bool(1)))
			spawnWisp(false);

		if (FlxG.random.bool(0.1) || (CrazyMode && FlxG.random.bool(20)))
			spawnGhost();
		if (CrazyMode && FlxG.random.bool(0.5))
			spawnJack();
		if (FlxG.keys.anyJustPressed([ONE]))
			CrazyMode != CrazyMode;
	}

	private function jackBounce(G:FlxSprite, J:FlxSprite):Void {}

	private function groundHit(G:FlxSprite, L:LeafBit):Void
	{
		L.hitCheck(G);
	}

	private function leavesHit(LA:LeafBit, LB:LeafBit):Void
	{
		LA.hitCheck(LB);
		LB.hitCheck(LA);
	}

	private function spawnJack():Void {}

	private function spawnWisp(Back:Bool = false):Void {}

	private function spawnGhost():Void {}

	private function spawnLeaf():Void
	{
		var l:LeafBit = leaves.getFirstAvailable();

		var pos:FlxPoint = FlxPoint.get();
		if (wind > 0)
			pos.x = -1;
		else if (wind < 0)
			pos.x = FlxG.width + 1;
		else
			pos.x = FlxG.random.bool() ? -1 : FlxG.width + 1;

		pos.y = FlxG.random.int(0, FlxG.height) - 16;

		if (l == null)
			l = new LeafBit(pos.x, pos.y, FlxG.random.int(1, 2));
		else
			l.reset(pos.x, pos.y);
	}
}
