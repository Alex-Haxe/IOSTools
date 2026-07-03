package iostools.network;

#if cpp
import cpp.Prime;
#end
/**
 * When called on an iOS device, it instantly sends the link to open Safari.
 * Example: IOSBrowser.open("https://github.com");
*/
@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class IOSBrowser {

    #if ios
    private static var ios_browser_open_url = Prime._load("iosbrowser", "ios_browser_open_url", "vs", false);
    #end

    public static function open(url:String):Void {
        #if ios
        ios_browser_open_url(url);
        #end
    }
}
