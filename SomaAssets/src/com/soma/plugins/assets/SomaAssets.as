package com.soma.plugins.assets {

	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.plugins.assets.vo.SomaAssetsVO;
	import com.soma.plugins.assets.wires.SomaAssetsWire;

	import org.assetloader.AssetLoader;
	import org.assetloader.core.ILoader;

	/**
	 * @author Romuald Quantin
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
			if (_vo.instance && _vo.instance.injector && !_vo.instance.injector.hasMapping(SomaAssets, INJECTION_NAME)) {
				_vo.instance.injector.mapToInstance(SomaAssets, this, INJECTION_NAME);
			}
		}
		
		private function disposeInjectorMapping():void {
			if (_vo.instance && _vo.instance.injector && _vo.instance.injector.hasMapping(SomaAssets, INJECTION_NAME)) {
				_vo.instance.injector.removeMapping(SomaAssets, INJECTION_NAME);
			}
		}

		private function disposeWire():void {
			if (_vo.instance && _vo.instance.hasWire(SomaAssetsWire.NAME)) {
				_vo.instance.removeWire(SomaAssetsWire.NAME);
			}
		}

		public function dispose():void {
			if (!_vo) return;
			disposeWire();
			disposeInjectorMapping();
			_vo.dispose();
			_vo = null;
		}

		public function addConfig(data:String):Boolean {
			if (!wire) return false;
			return wire.addConfig(data);
		}

		public function get wire():SomaAssetsWire {
			if (!_vo || ! _vo.instance) return null;
			return _vo.instance.getWire(SomaAssetsWire.NAME) as SomaAssetsWire;
		}
		
		public function get loader():AssetLoader {
			if (!wire) return null;
			return wire.loader;
		}

		public function get config():XML {
			if (!wire) return null;
			return wire.config;
		}

		public function get configLoaded():Boolean {
			if (!wire) return false;
			return wire.configLoaded;
		}

		public function getAssets(path:String):* {
			if (!wire) return null;
			return wire.getAssets(path);
		}

		public function getLoader(path:String):ILoader {
			if (!wire) return null;
			return wire.getLoader(path);
		}

		public function get vo():SomaAssetsVO {
			return _vo;
		}

	}
}
