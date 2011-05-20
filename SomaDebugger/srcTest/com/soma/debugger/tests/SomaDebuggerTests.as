package com.soma.debugger.tests {

	import org.flexunit.asserts.assertTrue;
	import com.soma.debugger.tests.support.DebuggerInjecteeCustomName;
	import com.soma.debugger.tests.support.DebuggerInjecteeBadName;
	import org.flexunit.asserts.assertNotNull;	import com.soma.debugger.tests.support.DebuggerInjectee;	import com.soma.core.di.SomaInjector;	import org.hamcrest.object.instanceOf;
	import org.hamcrest.assertThat;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.debugger.SomaDebugger;

	import mx.core.FlexGlobals;

	import flash.display.Stage;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 6, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */
	public class SomaDebuggerTests {				private var _soma:ISoma;
		private var _somaInjector:Soma;				private static var _stage:Stage;				[BeforeClass]		public static function runBeforeClass():void {			_stage = FlexGlobals.topLevelApplication.stage;
		}				[AfterClass]		public static function runAfterClass():void {			_stage = null;		} 				[Before]		public function runBefore():void {			_soma = new Soma(_stage);
			_somaInjector = new Soma(_stage, SomaInjector);
		}				[After]		public function runAfter():void {			_soma.dispose();
			_soma = null;
			_somaInjector.dispose();
			_somaInjector = null;
		}				
		[Test(expects="Error")]
		public function testInjectorMappingError():void {
			_somaInjector.createPlugin(SomaDebugger, new SomaDebuggerVO(_somaInjector));
			_somaInjector.injector.createInstance(DebuggerInjecteeBadName);
		}
		
		[Test]
		public function testInjectorMappingSuccess():void {
			_somaInjector.createPlugin(SomaDebugger, new SomaDebuggerVO(_somaInjector));
			var injectee:DebuggerInjectee = _somaInjector.injector.createInstance(DebuggerInjectee) as DebuggerInjectee;
			_somaInjector.injector.createInstance(DebuggerInjectee);
			assertTrue(_somaInjector.injector.hasMapping(SomaDebugger, SomaDebugger.NAME_DEFAULT));
			assertNotNull(injectee.debugger);
			assertThat(instanceOf(SomaDebugger), injectee.debugger);
		}
		
		[Test]
		public function testInjectorMappingCustomNameSuccess():void {
			_somaInjector.createPlugin(SomaDebugger, new SomaDebuggerVO(_somaInjector, "debuggerCustomName"));
			var injectee:DebuggerInjecteeCustomName = _somaInjector.injector.createInstance(DebuggerInjecteeCustomName) as DebuggerInjecteeCustomName;
			_somaInjector.injector.createInstance(DebuggerInjecteeCustomName);
			assertTrue(_somaInjector.injector.hasMapping(SomaDebugger, "debuggerCustomName"));
			assertNotNull(injectee.debugger);
			assertThat(instanceOf(SomaDebugger), injectee.debugger);
			assertTrue(injectee.debugger.name, "debuggerCustomName");
		}
		
	}}