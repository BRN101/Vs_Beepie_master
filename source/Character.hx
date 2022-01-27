package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_nya');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				//animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				//addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-miku':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND_MIKU');
				frames = tex;
		
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
		
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
		
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24);
				animation.addByPrefix('preAttack', 'bf pre attack', 24);
				animation.addByPrefix('attack', 'boyfriend attack', 24);
				animation.addByPrefix('dodge', 'boyfriend dodge', 24);
		
				addOffset('idle');
				addOffset("singUP", 6, 46);
				addOffset("singRIGHT", -48, 7);
				addOffset("singLEFT", 33, -6);
				addOffset("singDOWN", 18, -40);
				addOffset("singUPmiss", 4, 43);
				addOffset("singRIGHTmiss", -44, 19);
				addOffset("singLEFTmiss", 28, -4);
				addOffset("singDOWNmiss", 33, -38);
				addOffset("hey", 8, 19);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('hit', -2);
				addOffset('preAttack', -3);
				addOffset('attack', -1);
				addOffset('dodge', -42, 16);
		
				playAnim('idle');
		
				flipX = true;
	
		case 'bf-happy':
				var tex = Paths.getSparrowAtlas('characters/BFFLEIXA');
				frames = tex;
		
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS0', 24, false);
		
				addOffset('idle');
				addOffset("singUP", -30, 36);
				addOffset("singRIGHT", -60, 0);
				addOffset("singLEFT", 60, 1);
				addOffset("singDOWN", 47, -42);
				addOffset("singUPmiss", -30, 36);
				addOffset("singRIGHTmiss", -47, 0);
				addOffset("singLEFTmiss", 46, -11);
				addOffset("singDOWNmiss", 58, -42);
		
				playAnim('idle');
		
				flipX = true;

			case 'bf-sentao':
				var tex = Paths.getSparrowAtlas('characters/bftercero');
				frames = tex;
			
				trace(tex.frames.length);
			
				animation.addByPrefix('idle', 'bf  idle', 24, false);
				animation.addByPrefix('singUP', 'bfarriba', 24, false);
				animation.addByPrefix('singLEFT', 'bfdizquierda', 24, false);
				animation.addByPrefix('singRIGHT', 'bfderechaa', 24, false);
				animation.addByPrefix('singDOWN', 'bfabajo', 24, false);
				animation.addByPrefix('singUPmiss', 'bf arriba miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'bf left miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'bf derecha miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'bf down miss', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
			
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				addOffset('idle');
				addOffset("singUP", -1, 27);
				addOffset("singRIGHT", -2, 11);
				addOffset("singLEFT", 7, 13);
				addOffset("singDOWN", 9, -10);
				addOffset("singUPmiss", -3, 26);
				addOffset("singRIGHTmiss", 6, 11);
				addOffset("singLEFTmiss", 14, 14);
				addOffset("singDOWNmiss", 11, -9);
				addOffset('firstDeath', 41, -6);
				addOffset('deathLoop', 40, -9);
				addOffset('deathConfirm', 39, 55);	
	
				playAnim('idle');
		
				flipX = true;

			case 'beepie':
				tex = Paths.getSparrowAtlas('characters/beepienormal_assets');
				frames = tex;
				animation.addByPrefix('idle', 'beepie idle', 24);
				animation.addByPrefix('singUP', 'beepie up', 24);
				animation.addByPrefix('singRIGHT', 'beepie right', 24);
				animation.addByPrefix('singDOWN', 'beepie down', 24);
				animation.addByPrefix('singLEFT', 'beepie left', 24);
		
				addOffset('idle');
				addOffset("singUP", -16, 19);
				addOffset("singRIGHT", -72, 0);
				addOffset("singLEFT", 28, -9);
				addOffset("singDOWN", -60, -93);
		
				playAnim('idle');
				
			case 'beepie-demon':
				tex = Paths.getSparrowAtlas('characters/badbeepie');
				frames = tex;
				animation.addByPrefix('idle', 'beepie mad idle', 24);
				animation.addByPrefix('singUP', 'beepimalaup', 24);
				animation.addByPrefix('singRIGHT', 'beepiedemonio derecha', 24);
				animation.addByPrefix('singDOWN', 'beepiemalaabajo', 24);
				animation.addByPrefix('singLEFT', 'beepiemala izquierda', 24);
				animation.addByPrefix('get-ready', 'get ready sweaty', 8);
		
				addOffset('idle');
				addOffset("singUP", -14, 36);
				addOffset("singRIGHT", -83, -6);
				addOffset("singLEFT", 4, -38);
				addOffset("singDOWN", -27, 8);
				addOffset("get-ready", 91, 17);
			
				playAnim('idle');
	
			case 'beepie-unu':
				tex = Paths.getSparrowAtlas('characters/sadbeepie');
				frames = tex;
				animation.addByPrefix('idle', 'sad beepie idle', 24);
				animation.addByPrefix('singUP', 'sadbeepieup', 24);
				animation.addByPrefix('singRIGHT', 'sadbeepieright', 24);
				animation.addByPrefix('singDOWN', 'sadbeepiedownpose', 24);
				animation.addByPrefix('singLEFT', 'sadbeepieleft', 24);
			
				addOffset('idle');
				addOffset("singUP", -21, 35);
				addOffset("singRIGHT", -20, 4);
				addOffset("singLEFT", 15, -2);
				addOffset("singDOWN", 5, -33);
			
				playAnim('idle');
	
			case 'beepie-happy':
				tex = Paths.getSparrowAtlas('characters/happybeepie');
				frames = tex;
				animation.addByPrefix('idle', 'bepi feliz idle', 24);
				animation.addByPrefix('singUP', 'happy beepie up', 24);
				animation.addByPrefix('singRIGHT', 'happybeepie right', 24);
				animation.addByPrefix('singDOWN', 'happybeepi down', 24);
				animation.addByPrefix('singLEFT', 'happybeepueleft', 24);
				
				addOffset('idle');
				addOffset("singUP", 34, 29);
				addOffset("singRIGHT", -32, -10);
				addOffset("singLEFT", -29, -23);
				addOffset("singDOWN", -46, -40);
				
				playAnim('idle');
			case 'beepie-mine':
				tex = Paths.getSparrowAtlas('characters/beepiereal_assets');
				frames = tex;
				animation.addByPrefix('idle', 'beepietristeidle', 24);
				animation.addByPrefix('odioaspringy', 'bepi se saca la gorra', 24);

				addOffset('idle');

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
