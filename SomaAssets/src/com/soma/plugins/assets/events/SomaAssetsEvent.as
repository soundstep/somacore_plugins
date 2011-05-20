package com.soma.plugins.assets.events {

	import com.soma.plugins.assets.SomaAssets;
	import flash.events.Event;


	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class SomaAssetsEvent extends Event {

		public static const LOADER_READY:String = "SomaAssetsEvent.LOADER_READY";
		public static const LOADER_COMPLETE:String = "SomaAssetsEvent.LOADER_COMPLETE";
		
		public static const ASSET_LOADED:String = "SomaAssetsEvent.ASSET_LOADED";
		public static const CONFIG_LOADED:String = "SomaAssetsEvent.CONFIG_LOADED";
		
		public var plugin:SomaAssets;
		public var asset:*;
		public var path:String;
		public var config:XML;

		public function SomaAssetsEvent(type:String, plugin:SomaAssets, asset:* = null, path:String = null, config:XML = null, bubbles:Boolean = true, cancelable:Boolean = false) {
			this.path = path;
			this.asset = asset;
			this.config = config;
			this.plugin = plugin;
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			return new SomaAssetsEvent(type, plugin, asset, path, config, bubbles, cancelable);
		}
		
	}
}
