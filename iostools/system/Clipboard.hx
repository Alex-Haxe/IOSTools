package iostools.system;

#if cpp
import cpp.Prime;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class Clipboard {

    #if ios
    private static var ios_clipboard_set_text = Prime._load("iosclipboard", "ios_clipboard_set_text", "vs", false);
    private static var ios_clipboard_get_text = Prime._load("iosclipboard", "ios_clipboard_get_text", "s", false);
    #end

    public static function setText(text:String):Void {
        #if ios
        ios_clipboard_set_text(text);
        #end
    }

    public static function getText():String {
        #if ios
        return ios_clipboard_get_text();
        #else
        return "";
        #end
    }
}
