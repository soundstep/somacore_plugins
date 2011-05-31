package com.soma.plugins.assets.tests {

	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.events.SomaAssetsEvent;
	import com.soma.plugins.assets.vo.SomaAssetsVO;
	import com.soma.plugins.assets.wires.SomaAssetsWire;

	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.BaseLoader;
	import org.assetloader.loaders.BinaryLoader;
	import org.assetloader.loaders.CSSLoader;
	import org.assetloader.loaders.ImageLoader;
	import org.assetloader.loaders.JSONLoader;
	import org.assetloader.loaders.SWFLoader;
	import org.assetloader.loaders.SoundLoader;
	import org.assetloader.loaders.TextLoader;
	import org.assetloader.loaders.VideoLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;

	import mx.core.FlexGlobals;

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.media.Sound;
	import flash.net.NetStream;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */
	public class BaseTests {

		private static var _configXML:XML;
		private static var _configURL:String;
				private var _soma:ISoma;
		private var _somaConstructor:ISoma;
		
		private var _plugin:SomaAssets;
		private var _pluginConstructor:SomaAssets;
				private static var _stage:Stage;				[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;
			_configURL = "assets/xml/assets.xml";
			_configXML = <loader connections="3">
				<group id="group0" connections="1" preventCache="true">
					<group id="group00" connections="1" preventCache="true">
						<asset id="img0" src="assets/img/image00.jpg" smoothing="true" transparent="true" weight="174015"/>
						<asset id="img1" src="assets/img/image01.jpg" smoothing="true" transparent="true" weight="165158"/>
					</group>
					<asset id="img2" src="assets/img/image02.jpg" fillColor="0xFF0000" smoothing="true" transparent="true" weight="156926"/>
					<asset id="img3" src="assets/img/image03.jpg" fillColor="0xFF0000" smoothing="true" transparent="true" weight="177053"/>
				</group>
				<group id="group1" connections="2" preventCache="true">
					<asset id="swf0" src="assets/swf/flash0.swf" priority="1" weight="1915"/>
					<asset id="swf1" src="assets/swf/flash1.swf" priority="2" weight="2005"/>
				</group>
				<asset id="css" src="assets/css/stylesheet.css" preventCache="true" weight="352"/>
				<asset id="json" src="assets/json/data.json" preventCache="true" weight="582"/>
				<asset id="sound" src="assets/sounds/sample.mp3" preventCache="true" weight="16718"/>
				<asset id="text" src="assets/text/text.txt" preventCache="true" weight="574"/>
				<asset id="xml" src="assets/xml/sample.xml" preventCache="true" weight="79"/>
				<asset id="video" src="assets/video/sample.flv" weight="1550580"/>
				<asset id="zip" src="assets/zip/file.zip" weight="3493"/>
			</loader>;
		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);
			_somaConstructor = new Soma(_stage);
			_plugin = _soma.createPlugin(SomaAssets, new SomaAssetsVO(_soma)) as SomaAssets;		}				[After]		public function runAfter():void {
			_plugin.dispose();
			if (_pluginConstructor) _pluginConstructor.dispose();
			_soma.dispose();
			_somaConstructor.dispose();
			_somaConstructor = null;
			_soma = null;
			_plugin = null;
			_pluginConstructor = null;		}		
		[Test]
		public function testWireCreated():void {
			assertNotNull(_soma.getWire(SomaAssetsWire.NAME));
			assertThat(instanceOf(SomaAssetsWire), _soma.getWire(SomaAssetsWire.NAME));
		}
		
		[Test]
		public function testGetWireFromPlugin():void {
			assertNotNull(_plugin.wire);
			assertThat(instanceOf(SomaAssetsWire), _plugin.wire);
		}
		
		[Test]
		public function testLoaderCreated():void {
			assertNotNull(_soma.getWire(SomaAssetsWire.NAME));
			assertThat(instanceOf(SomaAssetsWire), _soma.getWire(SomaAssetsWire.NAME));
		}
		
		[Test]
		public function testGetLoaderFromPlugin():void {
			assertNotNull(_plugin.loader);
			assertThat(instanceOf(SomaAssetsWire), _plugin.loader);
		}
		
		[Test(async)]
		public function testAddConfigInContructorAsString():void {
			_somaConstructor.addEventListener(SomaAssetsEvent.CONFIG_LOADED, Async.asyncHandler(this, testAddConfigInContructorAsStringSuccess, 500, null, testAddConfigInContructorAsStringFailed));
			_pluginConstructor = _somaConstructor.createPlugin(SomaAssets, new SomaAssetsVO(_somaConstructor, _configURL)) as SomaAssets;
		}
		
		private function testAddConfigInContructorAsStringSuccess(event:SomaAssetsEvent, data:*):void {
			data;
			assertNotNull(_pluginConstructor.config);
			assertNotNull(_pluginConstructor.loader.config);
			assertTrue(_pluginConstructor.configLoaded);
		}

		private function testAddConfigInContructorAsStringFailed(event:SomaAssetsEvent):void {
			fail("testAddConfigInContructorAsString time out");
		}
		
		[Test]
		public function testAddConfigInContructorAsXML():void {
			_pluginConstructor = _somaConstructor.createPlugin(SomaAssets, new SomaAssetsVO(_somaConstructor, _configXML)) as SomaAssets;
			assertNotNull(_pluginConstructor.config);
			assertNotNull(_pluginConstructor.loader.config);
			assertTrue(_pluginConstructor.configLoaded);
		}
		
		[Test]
		public function testAddConfigInPluginAsString():void {
			_plugin.addConfig(_configURL);
		}
		
		[Test]
		public function testAddConfigInPluginAsXML():void {
			_plugin.addConfig(_configXML);
		}
		
		[Test]
		public function testAddConfigInLoaderAsString():void {
			_plugin.loader.addConfig(_configURL);
		}
		
		[Test]
		public function testAddConfigInLoaderAsXML():void {
			_plugin.loader.addConfig(_configXML);
		}
		
		[Test(async)]
		public function testConfigLoadedAsString():void {
			_soma.addEventListener(SomaAssetsEvent.CONFIG_LOADED, Async.asyncHandler(this, testConfigLoadedAsStringSuccess, 500, null, testConfigLoadedAsStringFailed));
			_plugin.addConfig(_configURL);
		}

		private function testConfigLoadedAsStringSuccess(event:SomaAssetsEvent, data:*):void {
			data;
			assertNotNull(_plugin.config);
			assertThat(_plugin.config, instanceOf(XML));
			assertTrue(_plugin.configLoaded);
		}

		private function testConfigLoadedAsStringFailed(event:SomaAssetsEvent):void {
			fail("testConfigLoadedAsString time out");
		}
		
		[Test]
		public function testConfigLoadedAsXML():void {
			_plugin.addConfig(_configXML);
			assertNotNull(_plugin.config);
			assertThat(_plugin.config, instanceOf(XML));
			assertTrue(_plugin.configLoaded);
		}
		
		[Test]
		public function testConfigLoadedBooleanFlagEventAsString():void {
			assertFalse(_plugin.addConfig(_configURL));
		}
		
		[Test]
		public function testConfigLoadedBooleanFlagEventAsXML():void {
			assertTrue(_plugin.addConfig(_configXML));
		}
		
		[Test]
		public function testGetLoaderMain():void {
			_plugin.addConfig(_configXML);
			assertNotNull(_plugin.getLoader(SomaAssets.LOADER_PRIMARY_GROUP_NAME));
			assertThat(_plugin.getLoader(SomaAssets.LOADER_PRIMARY_GROUP_NAME), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(SomaAssets.LOADER_PRIMARY_GROUP_NAME), _plugin.loader);
			assertEquals(_plugin.getLoader(SomaAssets.LOADER_PRIMARY_GROUP_NAME).id, SomaAssets.LOADER_PRIMARY_GROUP_NAME);
		}
		
		[Test]
		public function testGetLoaderMainCustomName():void {
			var originalName:String = SomaAssets.LOADER_PRIMARY_GROUP_NAME;
			var customName:String = "customPrimarypath";
			SomaAssets.LOADER_PRIMARY_GROUP_NAME = customName;
			var soma:ISoma = new Soma(_stage);
			_plugin = soma.createPlugin(SomaAssets, new SomaAssetsVO(soma)) as SomaAssets;
			_plugin.addConfig(_configXML);
			assertNotNull(_plugin.getLoader(customName));
			assertThat(_plugin.getLoader(customName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(customName), _plugin.loader);
			assertEquals(_plugin.getLoader(customName).id, customName);
			SomaAssets.LOADER_PRIMARY_GROUP_NAME = originalName;
			soma.dispose();
			soma = null;
		}
		
		[Test]
		public function testGetLoaderGroup():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, path);
		}
		
		[Test]
		public function testGetLoaderGroupDeeper():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0/group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
		}
		
		[Test]
		public function testGetLoaderGroupWithPrimaryGroup():void {
			_plugin.addConfig(_configXML);
			var path:String = "main/group0";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group0");
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithPrimaryGroup():void {
			_plugin.addConfig(_configXML);
			var path:String = "main/group0/group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithCustomDelimiter():void {
			SomaAssets.LOADER_PATH_DELIMITER = "_";
			var soma:ISoma = new Soma(_stage);
			_plugin = soma.createPlugin(SomaAssets, new SomaAssetsVO(soma)) as SomaAssets;
			_plugin.addConfig(_configXML);
			var path:String = "group0_group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
			soma.dispose();
			soma = null;
			SomaAssets.LOADER_PATH_DELIMITER = "/";
		}
		
		[Test]
		public function testGetLoaderGroupWithPrimaryGroupWithCustomDelimiter():void {
			SomaAssets.LOADER_PATH_DELIMITER = "_";
			var soma:ISoma = new Soma(_stage);
			_plugin = soma.createPlugin(SomaAssets, new SomaAssetsVO(soma)) as SomaAssets;
			_plugin.addConfig(_configXML);
			var path:String = "main_group0";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group0");
			soma.dispose();
			soma = null;
			SomaAssets.LOADER_PATH_DELIMITER = "/";
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithPrimaryGroupWithCustomDelimiter():void {
			SomaAssets.LOADER_PATH_DELIMITER = "_";
			var soma:ISoma = new Soma(_stage);
			_plugin = soma.createPlugin(SomaAssets, new SomaAssetsVO(soma)) as SomaAssets;
			_plugin.addConfig(_configXML);
			var path:String = "main_group0_group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
			soma.dispose();
			soma = null;
			SomaAssets.LOADER_PATH_DELIMITER = "/";
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithConstant():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0" + SomaAssets.LOADER_PATH_DELIMITER + "group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
		}
		
		[Test(expects="Error")]
		public function testGetLoaderGroupDeeperError():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0-group00";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(path).id, "group00");
		}
		
		[Test(expects="Error")]
		public function testGetLoaderAssetError():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(BaseLoader));
			assertEquals(_plugin.getLoader(path).id, "group0");
		}
		
		[Test]
		public function testGetLoaderAssetSuccess():void {
			_plugin.addConfig(_configXML);
			var path:String = "css";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(BaseLoader));
			assertThat(_plugin.getLoader(path), instanceOf(CSSLoader));
			assertEquals(_plugin.getLoader(path).id, "css");
		}
		
		[Test]
		public function testGetLoaderAssetDeeperSuccess():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0/group00/img0";
			assertNotNull(_plugin.getLoader(path));
			assertThat(_plugin.getLoader(path), instanceOf(BaseLoader));
			assertThat(_plugin.getLoader(path), instanceOf(ImageLoader));
			assertEquals(_plugin.getLoader(path).id, "img0");
		}
		
		[Test]
		public function testGetAssetsBeforeLoadingIsNull():void {
			_plugin.addConfig(_configXML);
			var path:String = "group0";
			assertNull(_plugin.getAssets(path));
		}
		
		[Test]
		public function testGetAssetsBeforeLoadingNotLoaded():void {
			_plugin.addConfig(_configXML);
			var path:String = "css";
			assertNull(_plugin.getAssets(path));
			assertFalse(_plugin.getLoader(path).loaded);
		}

		[Test(async)]
		public function testGetAssetGroupLoaded():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testGetAssetLoadedGroupSuccess, 500, null, testGetAssetLoadedGroupFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testGetAssetLoadedGroupSuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			var path:String = "group0";
			assertNotNull(_plugin.getAssets(path));
			assertThat(_plugin.getAssets(path), instanceOf(Dictionary));
		}
		
		private function testGetAssetLoadedGroupFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetGroupLoaded failed on time out");
		}

		[Test(async)]
		public function testGetAssetLoaded():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testGetAssetLoadedSuccess, 500, null, testGetAssetLoadedFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testGetAssetLoadedSuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			var path:String = "css";
			assertNotNull(_plugin.getAssets(path));
			assertThat(_plugin.getAssets(path), instanceOf(StyleSheet));
		}
		
		private function testGetAssetLoadedFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetLoaded failed on time out");
		}
		
		[Test(async)]
		public function testGetAssetLoadedWithPathFromDictionary():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testGetAssetLoadedWithPathFromDictionarySuccess, 500, null, testGetAssetLoadedWithPathFromDictionaryFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testGetAssetLoadedWithPathFromDictionarySuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			var path:String = "group0";
			assertNotNull(_plugin.getAssets(path));
			assertThat(_plugin.getAssets(path), instanceOf(Dictionary));
			assertNotNull(_plugin.getAssets(path)["group00"]["img0"]);
			assertThat(_plugin.getAssets(path)["group00"]["img0"], instanceOf(Bitmap));
		}
		
		private function testGetAssetLoadedWithPathFromDictionaryFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetLoadedWithPathFromDictionary failed on time out");
		}
		
		[Test(async)]
		public function testGetAssetGroupDeeperLoaded():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testGetAssetLoadedGroupDeeperSuccess, 500, null, testGetAssetLoadedGroupDeeperFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testGetAssetLoadedGroupDeeperSuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			var path:String = "group0/group00";
			assertNotNull(_plugin.getAssets(path));
			assertThat(_plugin.getAssets(path), instanceOf(Dictionary));
		}
		
		private function testGetAssetLoadedGroupDeeperFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetGroupDeeperLoaded failed on time out");
		}

		[Test(async)]
		public function testGetAssetLoadedDeeper():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testGetAssetLoadedDeeperSuccess, 500, null, testGetAssetLoadedDeeperFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testGetAssetLoadedDeeperSuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			var path:String = "group0/group00/img0";
			assertNotNull(_plugin.getAssets(path));
			assertThat(_plugin.getAssets(path), instanceOf(Bitmap));
		}
		
		private function testGetAssetLoadedDeeperFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetLoadedDeeper failed on time out");
		}
		
		[Test(async)]
		public function testType():void {
			_soma.addEventListener(SomaAssetsEvent.LOADER_COMPLETE, Async.asyncHandler(this, testTypeSuccess, 500, null, testTypeFailed));
			_plugin.addConfig(_configXML);
			_plugin.loader.start();
		}

		private function testTypeSuccess(event:SomaAssetsEvent, data:Object):void {
			data;
			// asset types
			assertNotNull(_plugin.getAssets("group0/group00/img0"));
			assertThat(_plugin.getAssets("group0/group00/img0"), instanceOf(Bitmap));
			assertNotNull(_plugin.getAssets("group1/swf0"));
			assertThat(_plugin.getAssets("group1/swf0"), instanceOf(MovieClip));
			assertNotNull(_plugin.getAssets("css"));
			assertThat(_plugin.getAssets("css"), instanceOf(StyleSheet));
			assertNotNull(_plugin.getAssets("json"));
			assertThat(_plugin.getAssets("json"), instanceOf(Object));
			assertNotNull(_plugin.getAssets("sound"));
			assertThat(_plugin.getAssets("sound"), instanceOf(Sound));
			assertNotNull(_plugin.getAssets("text"));
			assertThat(_plugin.getAssets("text"), instanceOf(String));
			assertNotNull(_plugin.getAssets("xml"));
			assertThat(_plugin.getAssets("xml"), instanceOf(XML));
			assertNotNull(_plugin.getAssets("video"));
			assertThat(_plugin.getAssets("video"), instanceOf(NetStream));
			assertNotNull(_plugin.getAssets("zip"));
			assertThat(_plugin.getAssets("zip"), instanceOf(ByteArray));
			// lodaer types
			assertNotNull(_plugin.getLoader("group0/group00/img0"));
			assertThat(_plugin.getLoader("group0/group00/img0"), instanceOf(ImageLoader));
			assertNotNull(_plugin.getLoader("group1/swf0"));
			assertThat(_plugin.getLoader("group1/swf0"), instanceOf(SWFLoader));
			assertNotNull(_plugin.getLoader("css"));
			assertThat(_plugin.getLoader("css"), instanceOf(CSSLoader));
			assertNotNull(_plugin.getLoader("json"));
			assertThat(_plugin.getLoader("json"), instanceOf(JSONLoader));
			assertNotNull(_plugin.getLoader("sound"));
			assertThat(_plugin.getLoader("sound"), instanceOf(SoundLoader));
			assertNotNull(_plugin.getLoader("text"));
			assertThat(_plugin.getLoader("text"), instanceOf(TextLoader));
			assertNotNull(_plugin.getLoader("xml"));
			assertThat(_plugin.getLoader("xml"), instanceOf(XMLLoader));
			assertNotNull(_plugin.getLoader("video"));
			assertThat(_plugin.getLoader("video"), instanceOf(VideoLoader));
			assertNotNull(_plugin.getLoader("zip"));
			assertThat(_plugin.getLoader("zip"), instanceOf(BinaryLoader));
		}
		
		private function testTypeFailed(event:SomaAssetsEvent):void {
			fail("testGetAssetType failed on time out");
		}
		
	}}
