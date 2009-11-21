package com.adobe.testbrowser
{
	import com.adobe.testbrowser.views.Browser;
	import flash.html.HTMLHost;
	import flash.html.HTMLWindowCreateOptions;
	import flash.html.HTMLLoader;
	import flash.events.Event;
	import mx.core.Window;
	
	public class CustomHost extends HTMLHost
	{
		public override function createWindow(options:HTMLWindowCreateOptions):HTMLLoader
		{
			var win:Window = new Window();
			win.width = 800;
			win.height = 600;
			var browser:Browser = new Browser();
			browser.addEventListener(Event.LOCATION_CHANGE,
				function(e:Event):void
				{
					win.status = "Loading " + e.target.locationBar.text;
				});
			browser.addEventListener(Event.COMPLETE,
				function(e:Event):void
				{
					win.status = "Done";
				});
			browser.percentHeight = 100;
			browser.percentWidth = 100;
			win.addChild(browser);
			win.open(true);
			return browser.html.htmlLoader;
		}
		
		public override function updateLocation(locationURL:String):void
		{
			this.htmlLoader.dispatchEvent(new Event(Event.LOCATION_CHANGE));
		}
	}
}