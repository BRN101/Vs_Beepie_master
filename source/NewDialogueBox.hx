package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class NewDialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var skipText:FlxText;
	var cutsceneImage:FlxSprite;
	var curAnim:String = '';

	var curCharacter:String = '';
	var emotion:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	//basic portraits
	var portraitLeft:FlxSprite;
	var portraitLeft2:FlxSprite; //(BRN) IDK WHY I NEED TO MAKE ANOTHER PORTRAIT
	var portraitRight:FlxSprite;
	var portraitGF:FlxSprite;

	//STALKER EMOTIONS
	var portraitBeepieHappy:FlxSprite;
	var portraitBeepieShadow:FlxSprite;
	var portraitBfScared:FlxSprite;
	var portraitBfWhat:FlxSprite;
	var portraitGFScared:FlxSprite;

	//DEMON EMOTIONS
	var portraitGFAngry:FlxSprite;

	//STREET EMOTIONS
	var portraitBeepieOk:FlxSprite;
	var portraitBeepieOk2:FlxSprite;
	var portraitBfFriends:FlxSprite;




	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var black:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>, ?startingBackground:FlxSprite)
	{
		super();

		cutsceneImage = startingBackground;

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'together forever':
				FlxG.sound.playMusic(Paths.music('fire'), 0);
				FlxG.sound.music.fadeIn(3, 0, 0.8);
		}

		black = new FlxSprite(-600, -300).makeGraphic(9000, 9000, FlxColor.BLACK); // make a big graphic so people cant see gameplay shit
		add(black);

		box = new FlxSprite(0, 390);
		box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
		box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
		box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
		box.width += 170;


		cutsceneImage = new FlxSprite(-330, -180);
		cutsceneImage.scale.set(1.2, 1.21);
		cutsceneImage.visible = false;
		add(cutsceneImage);	
		
		//var hasDialog = true;

		this.dialogueList = dialogueList;
		
		/*if (!hasDialog)
			return;*/

				//BASICS
				if (PlayState.SONG.song.toLowerCase()=='stalker')
				{
				    portraitLeft = new FlxSprite(-200, 150);
				    portraitLeft.frames = Paths.getSparrowAtlas('portraits/stalker/beepie', 'shared');
				    portraitLeft.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
				    portraitLeft.updateHitbox();
				    portraitLeft.scrollFactor.set();
				    add(portraitLeft);
				    portraitLeft.visible = false;

					portraitLeft2 = new FlxSprite(-200, 150);
				    portraitLeft2.frames = Paths.getSparrowAtlas('portraits/stalker/beepie', 'shared');
				    portraitLeft2.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft2.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.2));
				    portraitLeft2.updateHitbox();
				    portraitLeft2.scrollFactor.set();
				    add(portraitLeft2);
				    portraitLeft2.visible = false;
		
				    
				}
				else if (PlayState.SONG.song.toLowerCase()=='together forever' || PlayState.SONG.song.toLowerCase()=='mine')
				{
					portraitLeft = new FlxSprite(-400, 150);
				    portraitLeft.frames = Paths.getSparrowAtlas('portraits/demon/beepiemala', 'shared');
				    portraitLeft.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
				    portraitLeft.updateHitbox();
				    portraitLeft.scrollFactor.set();
				    add(portraitLeft);
				    portraitLeft.visible = false;

					portraitLeft2 = new FlxSprite(-400, 150);
				    portraitLeft2.frames = Paths.getSparrowAtlas('portraits/demon/beepiemala', 'shared');
				    portraitLeft2.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft2.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.2));
				    portraitLeft2.updateHitbox();
				    portraitLeft2.scrollFactor.set();
				    add(portraitLeft2);
				    portraitLeft2.visible = false;
				}
				else if (PlayState.SONG.song.toLowerCase()=='that i need' || PlayState.SONG.song.toLowerCase()=='its ok')
				{
				    portraitLeft = new FlxSprite(-200, 150);
				    portraitLeft.frames = Paths.getSparrowAtlas('portraits/street/beepietriste', 'shared');
				    portraitLeft.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
					portraitLeft.flipX = true;
				    portraitLeft.updateHitbox();
				    portraitLeft.scrollFactor.set();
				    add(portraitLeft);
				    portraitLeft.visible = false;

					portraitLeft2 = new FlxSprite(-200, 150);
				    portraitLeft2.frames = Paths.getSparrowAtlas('portraits/street/beepietriste', 'shared');
				    portraitLeft2.animation.addByPrefix('enter', 'dialogue', 24, true);
				    portraitLeft2.animation.addByPrefix('stop', 'stop', 24, false);
				    portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.2));
					portraitLeft2.flipX = true;
				    portraitLeft2.updateHitbox();
				    portraitLeft2.scrollFactor.set();
				    add(portraitLeft2);
				    portraitLeft2.visible = false;
				}

				portraitRight = new FlxSprite(900, 150);
				portraitRight.frames = Paths.getSparrowAtlas('portraits/stalker/bf', 'shared');
				portraitRight.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitRight.animation.addByPrefix('stop', 'stop', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.2));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;

				portraitGF = new FlxSprite(900, 150);
				portraitGF.frames = Paths.getSparrowAtlas('portraits/stalker/gf', 'shared');
				portraitGF.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitGF.animation.addByPrefix('stop', 'stop', 24, false);
				portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.2));
				portraitGF.updateHitbox();
				portraitGF.scrollFactor.set();
				add(portraitGF);
				portraitGF.visible = false;

				portraitBeepieHappy = new FlxSprite(-200, 150);
				portraitBeepieHappy.frames = Paths.getSparrowAtlas('portraits/stalker/beepie-happy', 'shared');
				portraitBeepieHappy.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBeepieHappy.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBeepieHappy.setGraphicSize(Std.int(portraitBeepieHappy.width * PlayState.daPixelZoom * 0.2));
				portraitBeepieHappy.updateHitbox();
				portraitBeepieHappy.scrollFactor.set();
				add(portraitBeepieHappy);
				portraitBeepieHappy.visible = false;

				portraitBeepieShadow = new FlxSprite(-200, 150);
				portraitBeepieShadow.frames = Paths.getSparrowAtlas('portraits/stalker/beepie-shadow', 'shared');
				portraitBeepieShadow.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBeepieShadow.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBeepieShadow.setGraphicSize(Std.int(portraitBeepieShadow.width * PlayState.daPixelZoom * 0.2));
				portraitBeepieShadow.updateHitbox();
				portraitBeepieShadow.scrollFactor.set();
				add(portraitBeepieShadow);
				portraitBeepieShadow.visible = false;

				portraitBfScared = new FlxSprite(900, 150);
				portraitBfScared.frames = Paths.getSparrowAtlas('portraits/stalker/bf-scared', 'shared');
				portraitBfScared.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBfScared.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBfScared.setGraphicSize(Std.int(portraitBfScared.width * PlayState.daPixelZoom * 0.2));
				portraitBfScared.updateHitbox();
				portraitBfScared.scrollFactor.set();
				add(portraitBfScared);
				portraitBfScared.visible = false;

				portraitBfWhat = new FlxSprite(900, 150);
				portraitBfWhat.frames = Paths.getSparrowAtlas('portraits/stalker/bf-what', 'shared');
				portraitBfWhat.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBfWhat.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBfWhat.setGraphicSize(Std.int(portraitBfWhat.width * PlayState.daPixelZoom * 0.2));
				portraitBfWhat.updateHitbox();
				portraitBfWhat.scrollFactor.set();
				add(portraitBfWhat);
				portraitBfWhat.visible = false;

				portraitGFScared = new FlxSprite(900, 150);
				portraitGFScared.frames = Paths.getSparrowAtlas('portraits/stalker/gf-scared', 'shared');
				portraitGFScared.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitGFScared.animation.addByPrefix('stop', 'stop', 24, false);
				portraitGFScared.setGraphicSize(Std.int(portraitGFScared.width * PlayState.daPixelZoom * 0.2));
				portraitGFScared.updateHitbox();
				portraitGFScared.scrollFactor.set();
				add(portraitGFScared);
				portraitGFScared.visible = false;

				portraitGFAngry = new FlxSprite(900, 150);
				portraitGFAngry.frames = Paths.getSparrowAtlas('portraits/demon/gfenojada', 'shared');
				portraitGFAngry.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitGFAngry.animation.addByPrefix('stop', 'stop', 24, false);
				portraitGFAngry.setGraphicSize(Std.int(portraitGFAngry.width * PlayState.daPixelZoom * 0.2));
				portraitGFAngry.updateHitbox();
				portraitGFAngry.scrollFactor.set();
				add(portraitGFAngry);
				portraitGFAngry.visible = false;

				portraitBeepieOk = new FlxSprite(-200, 150);
				portraitBeepieOk.frames = Paths.getSparrowAtlas('portraits/street/beepieentiende', 'shared');
				portraitBeepieOk.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBeepieOk.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBeepieOk.setGraphicSize(Std.int(portraitBeepieOk.width * PlayState.daPixelZoom * 0.2));
				portraitBeepieOk.updateHitbox();
				portraitBeepieOk.scrollFactor.set();
				add(portraitBeepieOk);
				portraitBeepieOk.visible = false;

				portraitBeepieOk2 = new FlxSprite(-200, 150);
				portraitBeepieOk2.frames = Paths.getSparrowAtlas('portraits/street/beepieentendio2', 'shared');
				portraitBeepieOk2.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBeepieOk2.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBeepieOk2.setGraphicSize(Std.int(portraitBeepieOk2.width * PlayState.daPixelZoom * 0.2));
				portraitBeepieOk2.updateHitbox();
				portraitBeepieOk2.scrollFactor.set();
				add(portraitBeepieOk2);
				portraitBeepieOk2.visible = false;

				portraitBfFriends = new FlxSprite(900, 150);
				portraitBfFriends.frames = Paths.getSparrowAtlas('portraits/street/friends', 'shared');
				portraitBfFriends.animation.addByPrefix('enter', 'dialogue', 24, true);
				portraitBfFriends.animation.addByPrefix('stop', 'stop', 24, false);
				portraitBfFriends.setGraphicSize(Std.int(portraitBfFriends.width * PlayState.daPixelZoom * 0.2));
				portraitBfFriends.updateHitbox();
				portraitBfFriends.scrollFactor.set();
				add(portraitBfFriends);
				portraitBfFriends.visible = false;
		
		box.animation.play('normalOpen');

		if (PlayState.SONG.song.toLowerCase()=='that i need' || PlayState.SONG.song.toLowerCase()=='its ok')
		{
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.20));
		}
		else
		    box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.23));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

	

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(-42, 552, Std.int(FlxG.width * 1), "", 50);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(-40, 550, Std.int(FlxG.width * 1), "", 50);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		skipText = new FlxText(1120, (FlxG.height * 0.9) + 200, 0, "Press Esc to skip");
		skipText.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//skipText.screenCenter();
		add(skipText);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		if (cutsceneImage.alpha < 1)
			cutsceneImage.alpha += 1 * elapsed;

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.BACK && dialogueStarted && !isEnding)
		{
			isEnding = true;

			remove(black);

			if (PlayState.SONG.song.toLowerCase() == 'together forever')
				FlxG.sound.music.fadeOut(2.2, 0);


			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				box.alpha -= 1 / 5;
				//bgFade.alpha -= 1 / 5 * 0.7;
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				swagDialogue.alpha -= 1 / 5;
				dropText.alpha = swagDialogue.alpha;
				remove(cutsceneImage);
				skipText.alpha -= 1 / 5;
			}, 5);

			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				finishThing();
				kill();
			});
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					remove(black);

					if (PlayState.SONG.song.toLowerCase() == 'together forever')
						FlxG.sound.music.fadeOut(2.2, 0);
		

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						//bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitLeft2.visible = false;
						portraitRight.visible = false;
						portraitGF.visible = false;
						portraitBeepieHappy.visible = false;
						portraitBeepieShadow.visible = false;
						portraitBfScared.visible = false;
						portraitBfWhat.visible = false;
						portraitGFScared.visible = false;
						portraitGFAngry.visible = false;
						portraitBeepieOk.visible = false;
						portraitBeepieOk2.visible = false;
						portraitBfFriends.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
						remove(cutsceneImage);
						skipText.alpha -= 1 / 5;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	function endAnimation():Void 
	{
		portraitLeft.animation.play('stop', true);
		portraitLeft2.animation.play('stop', true);
	    portraitRight.animation.play('stop', true);
	    portraitGF.animation.play('stop', true);
	    portraitBeepieHappy.animation.play('stop', true);
	    portraitBeepieShadow.animation.play('stop', true);
	    portraitBfScared.animation.play('stop', true);
	    portraitBfWhat.animation.play('stop', true);
	    portraitGFScared.animation.play('stop', true);
	    portraitGFAngry.animation.play('stop', true);
	    portraitBeepieOk.animation.play('stop', true);
	    portraitBeepieOk2.animation.play('stop', true);
	    portraitBfFriends.animation.play('stop', true);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		var setDialogue = false;
		var skipDialogue = false;
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		swagDialogue.completeCallback = endAnimation;

		switch (curCharacter)
		{
			case 'beepie':
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');

					box.flipX = true;
				}
			case 'beepie2':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitLeft2.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');

					box.flipX = true;
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');

					box.flipX = false;
				}
			case 'bf-scared':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfWhat.visible = false; 
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBfScared.visible)
				{
					portraitBfScared.visible = true;
					portraitBfScared.animation.play('enter');

					box.flipX = false;
				}
			case 'sex':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
			case 'bf-what':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBfWhat.visible)
				{
					portraitBfWhat.visible = true;
					portraitBfWhat.animation.play('enter');

					box.flipX = false;
				}
			case 'beepie-happy':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBeepieHappy.visible)
				{
					portraitBeepieHappy.visible = true;
					portraitBeepieHappy.animation.play('enter');

					box.flipX = true;
				}
			case 'beepie-shadow':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBeepieShadow.visible)
				{
					portraitBeepieShadow.visible = true;
					portraitBeepieShadow.animation.play('enter');

					box.flipX = true;
				}
			case 'gf-scared':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitGFScared.visible)
				{
					portraitGFScared.visible = true;
					portraitGFScared.animation.play('enter');

					box.flipX = false;
				}
			case 'gf':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false;
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitGF.visible)
				{
					portraitGF.visible = true;
					portraitGF.animation.play('enter');

					box.flipX = false;
				}
			case 'gf-angry':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false; 
				portraitGFScared.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitGFAngry.visible)
				{
					portraitGFAngry.visible = true;
					portraitGFAngry.animation.play('enter');

					box.flipX = false;
				}
			case 'beepie-ok':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false; 
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk2.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBeepieOk.visible)
				{
					portraitBeepieOk.visible = true;
					portraitBeepieOk.animation.play('enter');

					box.flipX = true;
				}
			case 'beepie-ok2':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false; 
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBfFriends.visible = false;
				if (!portraitBeepieOk2.visible)
				{
					portraitBeepieOk2.visible = true;
					portraitBeepieOk2.animation.play('enter');

					box.flipX = true;
				}
			case 'bf-friends':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBeepieHappy.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfScared.visible = false;
				portraitBfWhat.visible = false; 
				portraitGFScared.visible = false;
				portraitGFAngry.visible = false;
				portraitBeepieOk.visible = false;
				portraitBeepieOk2.visible = false;
				if (!portraitBfFriends.visible)
				{
					portraitBfFriends.visible = true;
					portraitBfFriends.animation.play('enter');

					box.flipX = false;
				}
			case "bg":
				trace(curAnim);
				skipDialogue = true;
				switch(curAnim){
					case "hide":
						cutsceneImage.visible = false;
					default:
						cutsceneImage.visible = true;
						cutsceneImage.alpha = 0;
						cutsceneImage.loadGraphic(Paths.image('CUTSCENES/' + curAnim));
				}
		}

		if(skipDialogue)
		{
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curAnim = splitName[2];
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}