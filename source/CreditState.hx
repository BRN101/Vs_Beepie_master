package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class CreditState extends MusicBeatState
{
	var curSelected:Int = 0;
	var onSpecial:Bool = false;
	var credicons:FlxTypedGroup<FlxSprite>;
	var menuRoles:FlxTypedGroup<FlxText>;
	var menuItems:FlxTypedGroup<Alphabet>;
	//NAMES
	#if !switch
	var optionShit:Array<String> = [
		'valengarfy',
		'brn',
		'blueby',
		'stickman',
		'springy teze',
		'koichis',
		'kimakurus',
		'sickaric',
	    'bbpanzu',
	    'fore',];
	#else
	var optionShit:Array<String> = [
		'valengarfy',
		'brn',
		'blueby',
		'stickman',
		'springy teze',
		'koichis',
		'kimakurus',
		'sickaric',
	    'bbpanzu',
	    'fore',];
	#end
	//ROLES
	#if !switch
	var credinfolist:Array<String> = [
		'Creator, Artist and Animator',
		'Main Coder',
		'Musician',
		'Coder',
		'Charter',
		'Charter',
		'Musician',
		'Co-Creator, Artist and Beepie Voice',
	    'Thanks for the last song',
	    'Thanks for helping with animations',];
	#else
	var credinfolist:Array<String> = [
		'Creator, Artist and Animator',
		'Main Coder',
		'Musician',
		'Coder',
		'Charter',
		'Charter',
		'Musician',
		'Co-Creator, Artist and Beepie Voice', //checkpoint
	    'Thanks for the last song',
	    'Thanks for helping with animations',];
	#end
	//ICONS
	#if !switch
	var crediconlist:Array<String> = [
		'VALEN',
		'BRN',
		'BLUBI',
		'STICK',
		'SPRINGY',
		'KOICHIS',
		'KIMA',
		'SICK',
	    'BBPANZU',
	    'FORE',];
	#else
	var crediconlist:Array<String> = [
		'VALEN',
		'BRN',
		'BLUBI',
		'STICK',
		'KOICHIS',
		'SPRINGY',
		'KIMA',
		'SICK',
	    'BBPANZU',
	    'FORE',];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.4" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	var creditRoleText:FlxText;
	var creditNameText:FlxText;
	var creditSpecialChange:FlxText;
	var specialThanksText:FlxText;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.15;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.15;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

		//NAMES
		menuItems = new FlxTypedGroup<Alphabet>();
		add(menuItems);

		//var tex = Paths.getSparrowAtlas('credits/names');
		for (i in 0...optionShit.length)
		{
			var menuItem:Alphabet = new Alphabet(0, (70 * i) + 30, optionShit[i], true, false, true);
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(0, 0);
			menuItem.antialiasing = true;
			FlxTween.tween(menuItem, {x: 50, alpha: 1}, 1, {type: FlxTweenType.ONESHOT, ease: FlxEase.quadInOut});
		}

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		var tex = Paths.getSparrowAtlas('ICONSS');

		//ICONS
		credicons = new FlxTypedGroup<FlxSprite>();
		add(credicons);

		for (i in 0...crediconlist.length)
			{
				var crediticon:FlxSprite = new FlxSprite(650, 130);
				crediticon.angle = -10;
				crediticon.frames = tex;
				crediticon.animation.addByPrefix('idle', crediconlist[i] + " basic", 24);
				crediticon.animation.addByPrefix('selected', crediconlist[i] + " white", 24);
				crediticon.animation.play('idle');
				crediticon.ID = i;
				crediticon.scale.set(1, 1);
				credicons.add(crediticon);
				crediticon.scrollFactor.set();
				crediticon.antialiasing = true;
				FlxTween.tween(crediticon, {angle: 10}, 2.5, {type: FlxTweenType.PINGPONG, ease: FlxEase.quadInOut});
			}
		
		//ROLES
		
		creditRoleText = new FlxText(680, 530, 420, "", 38);
		creditRoleText.setFormat(Paths.font("vcr.ttf"), 38, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		creditRoleText.text = "";
		creditRoleText.scrollFactor.set();
		creditRoleText.borderSize = 2;
		add(creditRoleText);
	
		creditNameText = new FlxText(680, 80, 460, "", 48);
		creditNameText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		creditNameText.text = "";
		creditNameText.scrollFactor.set();
		creditNameText.borderSize = 2;
		add(creditNameText);


		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new MainMenuState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

					var daChoice:String = optionShit[curSelected];

					switch (daChoice)
					{
						case 'valengarfy':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/oh_pls_jsjss", "&"]);
							#else
							FlxG.openURL('https://twitter.com/oh_pls_jsjss');
							#end
						case 'brn':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/BRN101Dev", "&"]);
							#else
							FlxG.openURL('https://twitter.com/BRN101Dev');
							#end
						case 'blueby':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/blueby87", "&"]);
							#else
							FlxG.openURL('https://twitter.com/blueby87');
							#end
						case 'stickman':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/Stickman_911", "&"]);
							#else
							FlxG.openURL('https://twitter.com/Stickman_911');
							#end
						case 'springy teze':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/spr1n6tr4px", "&"]);
							#else
							FlxG.openURL('https://twitter.com/spr1n6tr4px');
							#end
						case 'koichis':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/m4_koi", "&"]);
							#else
							FlxG.openURL('https://twitter.com/m4_koi');
							#end
						case 'kimakurus':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/KimakurusMusic", "&"]);
							#else
							FlxG.openURL('https://twitter.com/KimakurusMusic');
							#end
						case 'sickaric':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/Sickaric_", "&"]);
							#else
							FlxG.openURL('https://twitter.com/Sickaric_');
							#end
						case 'bbpanzu':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/bbsub3", "&"]);
							#else
							FlxG.openURL('https://twitter.com/bbsub3');
							#end
						case 'fore':
							#if linux
							Sys.command('/usr/bin/xdg-open', ["https://twitter.com/Fore_8040", "&"]);
							#else
							FlxG.openURL('https://twitter.com/Fore_8040');
							#end
					}
				}
			}

		super.update(elapsed);

	}

	function changeItem(change:Int = 0)
	{
		curSelected += change;
		
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		credicons.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
				spr.alpha = 0;

				if (spr.ID == curSelected)
				{
					spr.animation.play('selected');
					spr.alpha = 1;
				}

				spr.updateHitbox();
			});

		switch (curSelected) //not the smartest way to do this but it works
		{
			case 0:
				creditRoleText.text = "Creator, Artist and Animator";
				creditNameText.text = "Valengarfy";
			case 1:
				creditRoleText.text = "Main Coder";	
				creditNameText.text = "BRN101";
			case 2:
				creditRoleText.text = "Musician";
				creditNameText.text = "Blueby87";
			case 3:
				creditRoleText.text = "Coder";
				creditNameText.text = "Stickman";
			case 4:
				creditRoleText.text = "Charter";
				creditNameText.text = "Springy teze";
			case 5:
				creditRoleText.text = "Charter";
				creditNameText.text = "Koichis";
			case 6:
				creditRoleText.text = "Musician";
				creditNameText.text = "Kimakurus";
			case 7:
				creditRoleText.text = "Co-Creator, Artist and Beepie Voice";
				creditNameText.text = "Sickaric";
			case 8:
				creditRoleText.text = "Thanks for the last song";
				creditNameText.text = "bbpanzu"; //checkpoint
			case 9:
				creditRoleText.text = "Thanks for helping with animations";
				creditNameText.text = "Fore8040";
			
		}
	}

}