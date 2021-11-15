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

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitBeepieEmo:FlxSprite;
	var portraitBeepieNormal:FlxSprite;
	var portraitBeepieShadow:FlxSprite;
	var portraitBfNormal:FlxSprite;
	var portraitBfKhe:FlxSprite;
	var portraitGfSus:FlxSprite;
	var portraitGfNormal:FlxSprite;
	var portraitGfHey:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'stalker':
				box = new FlxSprite(0, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns'){
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

	}   if (PlayState.SONG.song.toLowerCase()=='stalker'){

		//portraitLeft = new FlxSprite(250, 140);
		portraitLeft = new FlxSprite(250, 1000);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, true);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.13));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(750, 150);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/dialoguebfasustado');
		portraitRight.animation.addByPrefix('enter', 'dialoguebfasustado aameasuste', 24, true);
		portraitRight.animation.addByPrefix('stop', 'stop', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.13));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitBeepieEmo = new FlxSprite(150, 140);
		portraitBeepieEmo.frames = Paths.getSparrowAtlas('portraits/beepieemocionadadialoguo');
		portraitBeepieEmo.animation.addByPrefix('enter', 'beepieemocionadadialoguo aaaa', 24, true);
		portraitBeepieEmo.animation.addByPrefix('stop', 'stop', 24, false);
		portraitBeepieEmo.setGraphicSize(Std.int(portraitBeepieEmo.width * PlayState.daPixelZoom * 0.13));
		portraitBeepieEmo.updateHitbox();
		portraitBeepieEmo.scrollFactor.set();
		add(portraitBeepieEmo);
		portraitBeepieEmo.visible = false;

		portraitBeepieNormal = new FlxSprite(150, 140);
		portraitBeepieNormal.frames = Paths.getSparrowAtlas('portraits/beepienormaldialogue');
		portraitBeepieNormal.animation.addByPrefix('enter', 'beepienormaldialogue beepienormal', 24, true);
		portraitBeepieNormal.animation.addByPrefix('stop', 'stop', 24, false);
		portraitBeepieNormal.setGraphicSize(Std.int(portraitBeepieNormal.width * PlayState.daPixelZoom * 0.13));
		portraitBeepieNormal.updateHitbox();
		portraitBeepieNormal.scrollFactor.set();
		add(portraitBeepieNormal);
		portraitBeepieNormal.visible = false;

		portraitBeepieShadow = new FlxSprite(150, 140);
		portraitBeepieShadow.frames = Paths.getSparrowAtlas('portraits/beepienshadowdialogue');
		portraitBeepieShadow.animation.addByPrefix('enter', 'beepienormaldialogue beepienormal', 24, true);
		portraitBeepieShadow.animation.addByPrefix('stop', 'stop', 24, false);
		portraitBeepieShadow.setGraphicSize(Std.int(portraitBeepieShadow.width * PlayState.daPixelZoom * 0.13));
		portraitBeepieShadow.updateHitbox();
		portraitBeepieShadow.scrollFactor.set();
		add(portraitBeepieShadow);
		portraitBeepieShadow.visible = false;

		portraitBfNormal = new FlxSprite(750, 150);
		portraitBfNormal.frames = Paths.getSparrowAtlas('portraits/dialoguebfnormal');
		portraitBfNormal.animation.addByPrefix('enter', 'dialoguebfnormal normal', 24, true);
		portraitBfNormal.animation.addByPrefix('stop', 'stop', 24, false);
		portraitBfNormal.setGraphicSize(Std.int(portraitBfNormal.width * PlayState.daPixelZoom * 0.13));
		portraitBfNormal.updateHitbox();
		portraitBfNormal.scrollFactor.set();
		add(portraitBfNormal);
		portraitBfNormal.visible = false;

		portraitBfKhe = new FlxSprite(750, 150);
		portraitBfKhe.frames = Paths.getSparrowAtlas('portraits/dialoguebfque');
		portraitBfKhe.animation.addByPrefix('enter', 'dialoguebfque qie', 24, true);
		portraitBfKhe.animation.addByPrefix('stop', 'stop', 24, false);
		portraitBfKhe.setGraphicSize(Std.int(portraitBfKhe.width * PlayState.daPixelZoom * 0.13));
		portraitBfKhe.updateHitbox();
		portraitBfKhe.scrollFactor.set();
		add(portraitBfKhe);
		portraitBfKhe.visible = false;

		portraitGfSus = new FlxSprite(750, 150);
		portraitGfSus.frames = Paths.getSparrowAtlas('portraits/gfasustadadialogo');
		portraitGfSus.animation.addByPrefix('enter', 'gfasustadadialogo AAKESUSTO', 24, true);
		portraitGfSus.animation.addByPrefix('stop', 'stop', 24, false);
		portraitGfSus.setGraphicSize(Std.int(portraitGfSus.width * PlayState.daPixelZoom * 0.13));
		portraitGfSus.updateHitbox();
		portraitGfSus.scrollFactor.set();
		add(portraitGfSus);
		portraitGfSus.visible = false;

		portraitGfNormal = new FlxSprite(750, 150);
		portraitGfNormal.frames = Paths.getSparrowAtlas('portraits/gfnormaldialogo');
		portraitGfNormal.animation.addByPrefix('enter', 'gfnormaldialogo gfnormal', 24, true);
		portraitGfNormal.animation.addByPrefix('stop', 'stop', 24, false);
		portraitGfNormal.setGraphicSize(Std.int(portraitGfNormal.width * PlayState.daPixelZoom * 0.13));
		portraitGfNormal.updateHitbox();
		portraitGfNormal.scrollFactor.set();
		add(portraitGfNormal);
		portraitGfNormal.visible = false;

		portraitGfHey = new FlxSprite(750, 150);
		portraitGfHey.frames = Paths.getSparrowAtlas('portraits/gfsaludandodialogo');
		portraitGfHey.animation.addByPrefix('enter', 'gfsaludandodialogo holaa', 24, true);
		portraitGfHey.animation.addByPrefix('stop', 'stop', 24, false);
		portraitGfHey.setGraphicSize(Std.int(portraitGfHey.width * PlayState.daPixelZoom * 0.13));
		portraitGfHey.updateHitbox();
		portraitGfHey.scrollFactor.set();
		add(portraitGfHey);
		portraitGfHey.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.16));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

	}

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

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

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
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
        portraitRight.animation.play('stop', true);
        portraitBeepieEmo.animation.play('stop', true);
        portraitBeepieNormal.animation.play('stop', true);
		portraitBeepieShadow.animation.play('stop', true);
        portraitBfNormal.animation.play('stop', true);
        portraitBfKhe.animation.play('stop', true);
        portraitGfSus.animation.play('stop', true);
        portraitGfNormal.animation.play('stop', true);
        portraitGfHey.animation.play('stop', true);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
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
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'senpai':
				portraitRight.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');

					box.flipX = false;
				}
			case 'bfsus':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');

					box.flipX = false;
				}
			case 'beepieEmo':
				portraitRight.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitBeepieEmo.visible)
				{
					portraitBeepieEmo.visible = true;
					portraitBeepieEmo.animation.play('enter');

					box.flipX = false;
				}
			case 'beepienormal':
				portraitRight.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitBeepieNormal.visible)
				{
					portraitBeepieNormal.visible = true;
					portraitBeepieNormal.animation.play('enter');

					box.flipX = false;
				}
			case 'beepieshadow':
				portraitRight.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitBeepieShadow.visible)
				{
					portraitBeepieShadow.visible = true;
					portraitBeepieShadow.animation.play('enter');

					box.flipX = false;
				}
			case 'bfnormal':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitBfNormal.visible)
				{
					portraitBfNormal.visible = true;
					portraitBfNormal.animation.play('enter');

					box.flipX = false;
				}
			case 'bfkhe':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitBfKhe.visible)
				{
					portraitBfKhe.visible = true;
					portraitBfKhe.animation.play('enter');

					box.flipX = false;
				}
			case 'gfsus':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitGfSus.visible)
				{
					portraitGfSus.visible = true;
					portraitGfSus.animation.play('enter');

					box.flipX = false;
				}
			case 'gfnormal':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitGfNormal.visible)
				{
					portraitGfNormal.visible = true;
					portraitGfNormal.animation.play('enter');

					box.flipX = false;
				}
			case 'gfHi':
				portraitLeft.visible = false;
				portraitBeepieEmo.visible = false;
				portraitBeepieNormal.visible = false;
				portraitBeepieShadow.visible = false;
				portraitBfNormal.visible = false;
				portraitBfKhe.visible = false;
				portraitGfSus.visible = false;
				portraitGfNormal.visible = false;
				portraitGfHey.visible = false;
				if (!portraitGfHey.visible)
				{						
					portraitGfHey.visible = true;
					portraitGfHey.animation.play('enter');

					box.flipX = false;
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}