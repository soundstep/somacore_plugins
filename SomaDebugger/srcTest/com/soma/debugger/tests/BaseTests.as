package com.soma.debugger.tests {
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.assertThat;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.debugger.SomaDebugger;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class BaseTests {				private var _soma:ISoma;
				private static var _stage:Stage;				[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;
		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);		}				[After]		public function runAfter():void {			_soma.dispose();			_soma = null;		}				[Test(expects="Error")]
		public function testCreatePluginNull():void {
			_soma.createPlugin(null, null);
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameNull():void {
			_soma.createPluginFromClassName(null, null);
		}
		
		[Test]
		public function testCreatePluginBadVO():void {
			_soma.createPlugin(SomaDebugger, new SomaDebuggerVO(null));
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameBadClassName():void {
			_soma.createPluginFromClassName("bad", new SomaDebuggerVO(_soma));
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameBadVO():void {
			_soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", new SomaDebuggerVO(null));
		}
		
		[Test]
		public function testCreatePluginSuccess():void {
			_soma.createPlugin(SomaDebugger, new SomaDebuggerVO(_soma));
		}
		
		[Test]
		public function testCreatePluginFromClassNameSuccess():void {
			_soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", new SomaDebuggerVO(_soma));
		}
		
		[Test]
		public function testCreatePluginResult():void {
			var debugger:SomaDebugger = _soma.createPlugin(SomaDebugger, new SomaDebuggerVO(_soma)) as SomaDebugger;
			assertThat(debugger, instanceOf(SomaDebugger));
			
		}
		
		[Test]
		public function testCreatePluginFromClassNameResult():void {
			var debugger:SomaDebugger = _soma.createPluginFromClassName("com.soma.debugger.SomaDebugger", new SomaDebuggerVO(_soma)) as SomaDebugger;
			assertThat(debugger, instanceOf(SomaDebugger));
		}
		
	}}