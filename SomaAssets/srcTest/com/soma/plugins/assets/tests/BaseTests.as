package com.soma.plugins.assets.tests {

	import com.soma.assets.loader.core.IAssetLoader;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.events.SomaAssetsEvent;
	import com.soma.plugins.assets.vo.SomaAssetsVO;
	import com.soma.plugins.assets.wires.SomaAssetsWire;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
	/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */
	public class BaseTests {

		private static var _configXML:XML;
		private static var _configURL:String;
				private var _soma:ISoma;		private var _plugin:SomaAssets;
				private static var _stage:Stage;				[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;
			_configURL = "assets/xml/assets.xml";
			_configXML = <loader connections="3">
				<group id="group0" connections="1" preventCache="true">
					<group id="group00" connections="1" preventCache="true">
						<asset id="img0" src="img/image00.jpg" smoothing="true" transparent="true" weight="174015"/>
						<asset id="img1" src="img/image01.jpg" smoothing="true" transparent="true" weight="165158"/>
					</group>
					<asset id="img2" src="img/image02.jpg" fillColor="0xFF0000" smoothing="true" transparent="true" weight="156926"/>
					<asset id="img3" src="img/image03.jpg" fillColor="0xFF0000" smoothing="true" transparent="true" weight="177053"/>
				</group>
				<group id="group1" connections="2" preventCache="true">
					<asset id="swf0" src="swf/flash0.swf" priority="1" weight="1915"/>
					<asset id="swf1" src="swf/flash1.swf" priority="2" weight="2005"/>
				</group>
				<asset id="css" src="css/stylesheet.css" preventCache="true" weight="352"/>
				<asset id="json" src="json/data.json" preventCache="true" weight="582"/>
				<asset id="sound" src="sounds/sample.mp3" preventCache="true" weight="16718"/>
				<asset id="text" src="text/text.txt" preventCache="true" weight="574"/>
				<asset id="xml" src="xml/sample.xml" preventCache="true" weight="79"/>
				<asset id="video" src="video/sample.flv" weight="1550580"/>
			</loader>;
		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);			_plugin = _soma.createPlugin(SomaAssets, new SomaAssetsVO(_soma)) as SomaAssets;		}				[After]		public function runAfter():void {
			_plugin.dispose();			_soma.dispose();			_soma = null;			_plugin = null;		}		
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
			var customName:String = "customPrimaryGroupName";
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
			var groupName:String = "group0";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, groupName);
		}
		
		[Test]
		public function testGetLoaderGroupDeeper():void {
			_plugin.addConfig(_configXML);
			var groupName:String = "group0/group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
		}
		
		[Test]
		public function testGetLoaderGroupWithPrimaryGroup():void {
			_plugin.addConfig(_configXML);
			var groupName:String = "main/group0";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group0");
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithPrimaryGroup():void {
			_plugin.addConfig(_configXML);
			var groupName:String = "main/group0/group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithCustomDelimiter():void {
			SomaAssets.LOADER_PATH_DELIMITER = "_";
			var soma:ISoma = new Soma(_stage);
			_plugin = soma.createPlugin(SomaAssets, new SomaAssetsVO(soma)) as SomaAssets;
			_plugin.addConfig(_configXML);
			var groupName:String = "group0_group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
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
			var groupName:String = "main_group0";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group0");
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
			var groupName:String = "main_group0_group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
			soma.dispose();
			soma = null;
			SomaAssets.LOADER_PATH_DELIMITER = "/";
		}
		
		[Test]
		public function testGetLoaderGroupDeeperWithConstant():void {
			_plugin.addConfig(_configXML);
			var groupName:String = "group0" + SomaAssets.LOADER_PATH_DELIMITER + "group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
		}
		
		[Test(expects="Error")]
		public function testGetLoaderGroupDeeperError():void {
			_plugin.addConfig(_configXML);
			var groupName:String = "group0-group00";
			assertNotNull(_plugin.getLoader(groupName));
			assertThat(_plugin.getLoader(groupName), instanceOf(IAssetLoader));
			assertEquals(_plugin.getLoader(groupName).id, "group00");
		}
		
		[Test]
		public function testGetLoaderAsset():void {
			
		}
		
		[Test]
		public function testGetAssetErrorOnPath():void {
//			_plugin.addConfig(_configXML);
//			assertNull(_plugin.getAsset("group0"));
		}
		
		[Test]
		public function testGetAsset():void {
			
		}
		
	}}
