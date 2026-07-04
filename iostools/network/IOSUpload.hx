package iostools.network;

#if cpp
import cpp.Prime;
#end

class IOSUpload {
    #if ios
    private static var _uploadFile = Prime._prime("iostools_upload_file", "vss", false);
    #end

    /**
     * Uploads a file from the iOS Documents folder to a specified URL via HTTP POST.
     * @param url The server network address receiving the file.
     * @param filename The name of the file stored in the Documents folder to transfer.
     */
    public static function uploadFile(url:String, filename:String):Void {
        #if ios
        _uploadFile(url, filename);
        #else
        trace("IOSUpload: Upload is only supported on iOS.");
        #endif
    }
}
