package com.soma.plugins.assets.tests.support {

	import com.soma.assets.loader.loaders.BinaryLoader;
	import com.soma.assets.loader.loaders.VideoLoader;
	import com.soma.assets.loader.loaders.XMLLoader;
	import com.soma.assets.loader.loaders.TextLoader;
	import com.soma.assets.loader.loaders.SoundLoader;
	import com.soma.assets.loader.loaders.JSONLoader;
	import com.soma.assets.loader.loaders.CSSLoader;
	import com.soma.assets.loader.loaders.SWFLoader;
	import com.soma.assets.loader.loaders.ImageLoader;
	import flash.utils.ByteArray;
	import flash.net.NetStream;
	import flash.media.Sound;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.text.StyleSheet;
	import com.soma.assets.loader.core.ILoader;
	import com.soma.assets.loader.core.IAssetLoader;
	import com.soma.plugins.assets.SomaAssets;
	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class Injectee {
		
		[Inject(name="assets")]
		public var plugin:SomaAssets;
		
		[Inject(name="assets")]
		public var loader:IAssetLoader;
		
		[Inject(name="assets")]
		public var config:XML;
		
		[Inject(name="group0")]
		public var group1:IAssetLoader;
		
		[Inject(name="group0")]
		public var group2:ILoader;
		
		[Inject(name="group0/group00")]
		public var groupDeeper1:IAssetLoader;
		
		[Inject(name="group0/group00")]
		public var groupDeeper2:ILoader;
		
		[Inject(name="css")]
		public var assetLoader:ILoader;
		
		[Inject(name="group0/group00/img0")]
		public var assetLoaderDeeper:ILoader;
		
		[Inject(name="css")]
		public var asset:StyleSheet;
		
		[Inject(name="group0/group00/img0")]
		public var assetDeeper:Bitmap;
		
		// test asset types
		
		[Inject(name="group0/group00/img0")]
		public var assetType1:Bitmap;
		
		[Inject(name="group1/swf0")]
		public var assetType2:MovieClip;
		
		[Inject(name="css")]
		public var assetType3:StyleSheet;
		
		[Inject(name="json")]
		public var assetType4:Object;
		
		[Inject(name="sound")]
		public var assetType5:Sound;
		
		[Inject(name="text")]
		public var assetType6:String;
		
		[Inject(name="xml")]
		public var assetType7:XML;
		
		[Inject(name="video")]
		public var assetType8:NetStream;
		
		[Inject(name="zip")]
		public var assetType9:ByteArray;
		
		// test loader types
		
		[Inject(name="group0/group00/img0")]
		public var loaderType1:ImageLoader;
		
		[Inject(name="group1/swf0")]
		public var loaderType2:SWFLoader;
		
		[Inject(name="css")]
		public var loaderType3:CSSLoader;
		
		[Inject(name="json")]
		public var loaderType4:JSONLoader;
		
		[Inject(name="sound")]
		public var loaderType5:SoundLoader;
		
		[Inject(name="text")]
		public var loaderType6:TextLoader;
		
		[Inject(name="xml")]
		public var loaderType7:XMLLoader;
		
		[Inject(name="video")]
		public var loaderType8:VideoLoader;
		
		[Inject(name="zip")]
		public var loaderType9:BinaryLoader;
		
	}
}
