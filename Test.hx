#if !display
@:build(Extern.touch())
@:build(Extern.xml())
#end

class Test {
  static function run() {
      var mem = (new haxe.ds.Vector<cpp.Int32>(32)).toArray();
  }
}

