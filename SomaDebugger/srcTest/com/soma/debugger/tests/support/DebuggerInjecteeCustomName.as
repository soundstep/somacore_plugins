package com.soma.debugger.tests.support {
	import com.soma.debugger.SomaDebugger;
	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class DebuggerInjecteeCustomName {
		
		[Inject(name="debuggerCustomName")]
		public var debugger:SomaDebugger;
		
	}
}
