package iostools.ui;

#if cpp
import lime.system.CFFI;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class Alert {
    #if ios
    private static var ios_show_native_alert = CFFI.load("iostools", "ios_show_native_alert", 3);
    #end

    public static function show(title:String, message:String, buttonText:String = "OK"):Void {
        #if ios
        try {
            ios_show_native_alert(title, message, buttonText);
        } catch (e:Dynamic) {
            trace("Error calling native alert: " + e);
        }
        #end
    }
}
