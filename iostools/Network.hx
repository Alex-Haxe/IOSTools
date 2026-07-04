package iostools;

#if cpp
import cpp.Prime;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class Network {

    #if ios
    private static var ios_browser_open_url = Prime._load("iosbrowser", "ios_browser_open_url", "vs", false);
    private static var _downloadFile = Prime._prime("iostools_download_file", "vss", false);
    private static var _uploadFile = Prime._prime("iostools_upload_file", "vss", false);
    #end

    /**
     * When called on an iOS device, it instantly sends the link to open Safari.
     * Example: IOSBrowser.open("https://github.com");
    */
    public static function open(url:String):Void {
        #if ios
        ios_browser_open_url(url);
        #end
    }

    /**
     * Uploads a file from the iOS Documents folder to a specified URL via HTTP POST.
     * @param url The server network address receiving the file.
     * @param filename The name of the file stored in the Documents folder to transfer.
     */
    public static function upload(url:String, filename:String):Void {
        #if ios
        _uploadFile(url, filename);
        #end
    }

    /**
     * Downloads a file from a URL and saves it to the iOS Documents folder.
     * @param url The direct link to the file.
     * @param filename The name to save the file as (e.g., "save.dat").
     */
    public static function download(url:String, filename:String):Void {
        #if ios
        _downloadFile(url, filename);
        #end
    }
}
