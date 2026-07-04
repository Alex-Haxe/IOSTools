package iostools.network;

#if cpp
import cpp.Prime;
#end

class IOSDownloader {
    #if ios
    private static var _downloadFile = Prime._prime("iostools_download_file", "vss", false);
    #end

    /**
     * Downloads a file from a URL and saves it to the iOS Documents folder.
     * @param url The direct link to the file.
     * @param filename The name to save the file as (e.g., "save.dat").
     */
    public static function downloadFile(url:String, filename:String):Void {
        #if ios
        _downloadFile(url, filename);
        #else
        trace("IOSDownloader: Download is only supported on iOS.");
        #endif
    }
}
