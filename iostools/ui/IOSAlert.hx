package iostools.ui;

#if cpp
import cpp.Lib;
#end
  
@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class IOSAlert {
    public static function show(title:String, message:String, buttonText:String):Void {
        #if ios
        untyped __cpp__("iosalert::showAlert({0}.c_str(), {1}.c_str(), {2}.c_str())", title, message, buttonText);
        #end
    }
}
