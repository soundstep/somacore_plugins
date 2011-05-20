package com.soma.plugins.assets.tests {

	import org.hamcrest.object.instanceOf;	import org.hamcrest.assertThat;	import com.soma.plugins.assets.wires.SomaAssetsWire;	import org.flexunit.asserts.assertNotNull;	import com.soma.plugins.assets.vo.SomaAssetsVO;	import com.soma.plugins.assets.SomaAssets;	import com.soma.core.Soma;	import com.soma.core.interfaces.ISoma;	import mx.core.FlexGlobals;	import flash.display.Stage;
	/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */	public class DisposeTests {				private var _soma:ISoma;
				private static var _stage:Stage;				[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;
		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);			_soma.createPlugin(SomaAssets, new SomaAssetsVO(_soma));		}				[After]		public function runAfter():void {			_soma.dispose();			_soma = null;		}		
		[Test]
		public function testWireCreated():void {
			assertNotNull(_soma.getWire(SomaAssetsWire.NAME));			assertThat(instanceOf(SomaAssetsWire), _soma.getWire(SomaAssetsWire.NAME));
		}
		
	}}
