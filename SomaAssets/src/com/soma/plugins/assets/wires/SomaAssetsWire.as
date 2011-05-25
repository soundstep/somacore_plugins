package com.soma.plugins.assets.wires {

	import com.soma.assets.loader.AssetLoader;
	import com.soma.assets.loader.core.IAssetLoader;
	import com.soma.assets.loader.core.ILoader;
	import com.soma.assets.loader.events.AssetLoaderEvent;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.events.SomaAssetsEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;


	/**
	 * @author Romuald Quantin (romu@soundstep.com)
	 */
	public class SomaAssetsWire extends Wire implements IWire {

		public static const NAME:String = "SomaAssetsWire.NAME";
		
		private var _plugin:SomaAssets;
		private var _loader:AssetLoader;

		public function SomaAssetsWire(plugin:SomaAssets) {
			_plugin = plugin;
			super(NAME);
		}

		override public function initialize():void {
			createLoader();
		}

		private function createLoader():void {
			_loader = new AssetLoader(SomaAssets.LOADER_PRIMARY_GROUP_NAME);
			setListeners(_loader);
			createInjectorMapping();
			dispatchEvent(new SomaAssetsEvent(SomaAssetsEvent.LOADER_READY, _plugin));
		}

		private function createInjectorMapping():void {
			if (injector) {
				injector.mapToInstance(IAssetLoader, _loader, SomaAssets.INJECTION_NAME);
			}
		}

		private function disposeInjectorMapping():void {
			if (injector) {
				injector.removeMapping(IAssetLoader, SomaAssets.INJECTION_NAME);
			}
		}

		private function setListeners(target:IAssetLoader):void {
			target.addEventListener(AssetLoaderEvent.CONFIG_LOADED, configLoadedHandler);
			target.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
			
		}

		private function removeListeners(target:IAssetLoader):void {
			target.removeEventListener(AssetLoaderEvent.CONFIG_LOADED, configLoadedHandler);
			target.removeEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
		}

		private function configLoadedHandler(event:AssetLoaderEvent = null):void {
			parseAssets(_loader);
			dispatchEvent(new SomaAssetsEvent(SomaAssetsEvent.CONFIG_LOADED, _plugin, null, null, _loader.config));
		}

		private function completeHandler(event:AssetLoaderEvent):void {
			dispatchEvent(new SomaAssetsEvent(SomaAssetsEvent.LOADER_COMPLETE, _plugin, null, null, _loader.config));
		}

		private function getClass(instance:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(instance)));
		}

		private function parseAssets(target:ILoader):void {
			var path:String = getAssetPath(target, target.id);
			if (target is IAssetLoader) {
				var ids:Array = IAssetLoader(target).ids;
				var i:Number = 0;
				var l:Number = ids.length;
				for (; i<l; ++i) {
					if (injector) {
						// add IAssetLoader mapping
						if (!injector.hasMapping(IAssetLoader, path)) {
							injector.mapToInstance(IAssetLoader, target, path);
						}
					}
					parseAssets(IAssetLoader(target).getLoader(ids[i]));
				}
			}
			else {
				if (injector) {
					// add ILoader mapping
					if (!injector.hasMapping(ILoader, path)) {
						injector.mapToInstance(ILoader, target, path);
						injector.mapToInstance(getClass(target), target, path);
					}
					// add specific ILoader mapping (ImageLoader, SWFLoader, etc)
					var classAsset:Class = getClass(target);
					if (!injector.hasMapping(classAsset, path)) {
						injector.mapToInstance(classAsset, target, path);
					}
				}
				target.addEventListener(AssetLoaderEvent.COMPLETE, assetComplete);
			}
		}

		private function removeLoaderInjectorMapping(target:ILoader):void {
			if (!injector) return;
			var path:String = getAssetPath(target, target.id);
			if (target is IAssetLoader) {
				// contains loaders
				var ids:Array = IAssetLoader(target).ids;
				var i:Number = 0;
				var l:Number = ids.length;
				for (; i<l; ++i) {
					// remove IAssetLoader mapping
					if (injector.hasMapping(IAssetLoader, path)) {
						injector.removeMapping(IAssetLoader, path);
					}
					removeLoaderInjectorMapping(IAssetLoader(target).getLoader(ids[i]));
				}
			}
			else {
				// remove specific ILoader mapping (ImageLoader, SWFLoader, etc)
				var classLoader:Class = getClass(target);
				if (injector.hasMapping(classLoader, path)) {
					injector.removeMapping(classLoader, path);
				}
				// remove ILoader mapping
				if (injector.hasMapping(ILoader, path)) {
					injector.removeMapping(ILoader, path);
				}
				// remove asset mapping (Bitmap, MovieCLip, etc)
				if (target.data) {
					var classAsset:Class = getClass(target.data);
					if (injector.hasMapping(classAsset, path)) {
						injector.removeMapping(classAsset, path);
					}
				}
			}
		}

		private function getAssetPath(target:ILoader, path:String):String {
			var currentPath:String = path;
			if (target.parent && target.parent.id != SomaAssets.LOADER_PRIMARY_GROUP_NAME) {
				var newPath:String = target.parent.id + SomaAssets.LOADER_PATH_DELIMITER + path;
				currentPath = getAssetPath(target.parent, newPath);
			}
			return currentPath;
		}

		private function getLoaderFromPath(target:ILoader, path:Array):ILoader {
			if (!target) return null;
			var currentTarget:ILoader = target;
			if (target && target is IAssetLoader && path.length > 0) {
				var child:ILoader = IAssetLoader(target).getLoader(path[0]);
				path.shift();
				currentTarget = getLoaderFromPath(child, path);
			}
			return currentTarget;
		}

		private function getAssetFromLoader(target:ILoader, path:Array):Object {
			if (!target) return null;
			var loader:ILoader = getLoaderFromPath(target, path);
			if (!loader) return null;
			return loader.data;
		}

		private function assetComplete(event:AssetLoaderEvent):void {
			var loader:ILoader = event.currentTarget as ILoader;
			var path:String = getAssetPath(loader, loader.id);
			if (injector) {
				// add asset mapping (Bitmap, MovieClip, etc)
				var classAsset:Class = getClass(loader.data);
				if (!injector.hasMapping(classAsset, path)) {
					injector.mapToInstance(getClass(loader.data), loader.data, path);
				}
			}
			dispatchEvent(new SomaAssetsEvent(SomaAssetsEvent.ASSET_LOADED, _plugin, loader.data, path, _loader.config));
		}

		public function getAsset(path:String):* {
			return getAssetFromLoader(_loader, path.split(SomaAssets.LOADER_PATH_DELIMITER));
		}

		public function getLoader(path:String):ILoader {
			if (path == SomaAssets.LOADER_PRIMARY_GROUP_NAME) return _loader;
			var pathSplit:Array = path.split(SomaAssets.LOADER_PATH_DELIMITER);
			if (pathSplit.length > 0 && pathSplit[0] == SomaAssets.LOADER_PRIMARY_GROUP_NAME) {
				// remove unnecessary primary group name in path
				pathSplit.shift();
			}
			return getLoaderFromPath(_loader, pathSplit);
		}

		override public function dispose():void {
			removeLoaderInjectorMapping(_loader);
			removeListeners(_loader);
			disposeInjectorMapping();
			_loader.destroy();
			_loader = null;
			_plugin = null;
		}

		public function get loader():AssetLoader {
			return _loader;
		}

		public function get config():XML {
			return _loader.config;
		}

		public function addConfig(data:String):Boolean {
			var loaded:Boolean = _loader.addConfig(data);
			if (loaded) configLoadedHandler();
			return loaded;
		}

		public function get plugin():SomaAssets {
			return _plugin;
		}

		public function get configLoaded():Boolean {
			return _loader.config != null;
		}

	}
}
