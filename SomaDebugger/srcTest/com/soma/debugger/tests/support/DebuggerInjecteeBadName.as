package com.soma.debugger.tests.support {
	import com.soma.debugger.SomaDebugger;
	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class DebuggerInjecteeBadName {
		
		[Inject(name="BAD-NAME")]
		public var debugger:SomaDebugger;
		
	}
}
