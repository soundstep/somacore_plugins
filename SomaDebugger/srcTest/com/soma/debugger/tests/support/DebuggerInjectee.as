package com.soma.debugger.tests.support {
	import com.soma.debugger.SomaDebugger;
	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class DebuggerInjectee {
		
		[Inject(name="debugger")]
		public var debugger:SomaDebugger;
		
	}
}
