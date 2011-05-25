package com.soma.plugins.assets.tests {

	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.vo.SomaAssetsVO;
	import flash.display.Stage;
	import mx.core.FlexGlobals;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	
		
		}
		public function testCreatePluginNull():void {
			_soma.createPlugin(null, null);
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameNull():void {
			_soma.createPluginFromClassName(null, null);
		}
		
		[Test(expects="Error")]
		public function testCreatePluginBadVO():void {
			_soma.createPlugin(SomaAssets, new SomaAssetsVO(null));
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameBadClassName():void {
			_soma.createPluginFromClassName("bad", new SomaAssetsVO(_soma));
		}
		
		[Test(expects="Error")]
		public function testCreatePluginFromClassNameBadVO():void {
			_soma.createPluginFromClassName("com.soma.plugins.assets.SomaAssets", new SomaAssetsVO(null));
		}
		
		[Test]
		public function testCreatePluginSuccess():void {
			_soma.createPlugin(SomaAssets, new SomaAssetsVO(_soma));
		}
		
		[Test]
		public function testCreatePluginFromClassNameSuccess():void {
			_soma.createPluginFromClassName("com.soma.plugins.assets.SomaAssets", new SomaAssetsVO(_soma));
		}
		
		[Test]
		public function testCreatePluginResult():void {
			var debugger:SomaAssets = _soma.createPlugin(SomaAssets, new SomaAssetsVO(_soma)) as SomaAssets;
			assertThat(debugger, instanceOf(SomaAssets));
			
		}
		
		[Test]
		public function testCreatePluginFromClassNameResult():void {
			var debugger:SomaAssets = _soma.createPluginFromClassName("com.soma.plugins.assets.SomaAssets", new SomaAssetsVO(_soma)) as SomaAssets;
			assertThat(debugger, instanceOf(SomaAssets));
		}
		
	}