package com.soma.debugger.tests {

	import org.flexunit.asserts.assertTrue;
	import com.soma.debugger.tests.support.DebuggerInjecteeCustomName;
	import com.soma.debugger.tests.support.DebuggerInjecteeBadName;
	import org.flexunit.asserts.assertNotNull;
	import org.hamcrest.assertThat;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.debugger.SomaDebugger;

	import mx.core.FlexGlobals;

	import flash.display.Stage;

	public class SomaDebuggerTests {
		private var _somaInjector:Soma;
		}
			_somaInjector = new Soma(_stage, SomaInjector);
		}
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
		
	}