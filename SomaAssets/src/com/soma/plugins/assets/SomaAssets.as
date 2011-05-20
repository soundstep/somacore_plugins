package com.soma.plugins.assets {

	import com.soma.assets.loader.AssetLoader;
	import com.soma.assets.loader.core.ILoader;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.plugins.assets.vo.SomaAssetsVO;
	import com.soma.plugins.assets.wires.SomaAssetsWire;

	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class SomaAssets implements ISomaPlugin {
		
		public static var LOADER_PRIMARY_GROUP_NAME:String = "main";
		public static var LOADER_PATH_DELIMITER:String = "/";
		
		public static var INJECTION_NAME:String = "assets";
		
		private var _vo:SomaAssetsVO;

		public function initialize(pluginVO:ISomaPluginVO):void {
			if (!(pluginVO is SomaAssetsVO) || pluginVO == null) {
				throw new Error("Error in " + this + " The pluginVO is null or is not an instance of SomaAssetsVO");
			}
			try {
				var vo:SomaAssetsVO = pluginVO as SomaAssetsVO;
				if (vo == null || vo.instance == null || vo.instance.wires == null) throw new Error("Soma is not initialized properly.");
				_vo = pluginVO as SomaAssetsVO;
				createWire();
				createInjectorMapping();
			} catch (e:Error) {
				trace("Error in " + this + " " + e);
			}
		}

		private function createWire():void {
			_vo.instance.addWire(SomaAssetsWire.NAME, new SomaAssetsWire(this));
			if (_vo.config) {
				wire.addConfig(_vo.config);
			}
		}

		private function createInjectorMapping():void {
			if (_vo.instance.injector) {
				_vo.instance.injector.mapToInstance(SomaAssets, this, INJECTION_NAME);
			}
		}

		private function disposeWire():void {
			if (_vo.instance.hasWire(SomaAssetsWire.NAME)) {
				_vo.instance.removeWire(SomaAssetsWire.NAME);
			}
		}
		
		private function disposeInjectorMapping():void {
			if (_vo.instance.injector) {
				_vo.instance.injector.removeMapping(SomaAssets, INJECTION_NAME);
			}
		}

		public function dispose():void {
			disposeWire();
			disposeInjectorMapping();
			_vo.dispose();
			_vo = null;
		}

		public function addConfig(data:String):Boolean {
			return wire.addConfig(data);
		}

		public function get wire():SomaAssetsWire {
			return _vo.instance.getWire(SomaAssetsWire.NAME) as SomaAssetsWire;
		}
		
		public function get loader():AssetLoader {
			return wire.loader;
		}

		public function get config():XML {
			return wire.config;
		}

		public function get configLoaded():Boolean {
			return wire.configLoaded;
		}

		public function getAsset(path:String):* {
			return wire.getAsset(path);
		}

		public function getLoader(path:String):ILoader {
			return wire.getLoader(path);
		}

	}
}
