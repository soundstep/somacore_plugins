package com.soma.plugins.assets.vo {

	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPluginVO;

	/**
	 * @author Romuald Quantin
	 */
	public class SomaAssetsVO implements ISomaPluginVO {

		private var _instance:ISoma;
		private var _config:String;

		public function SomaAssetsVO(instance:ISoma, config:String = null) {
			if (instance == null) throw new Error("Error in " + this + " ISoma instance is null.");
			_instance = instance;
			_config = config;
		}

		public function get instance():ISoma {
			return _instance;
		}

		public function get config():String {
			return _config;
		}

		public function dispose():void {
			_instance = null;
			_config = null;
		}
	}
}
