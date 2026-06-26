package iostools.storage;

/**
 * When called on iOS, it lets you pick files, pick folders, or save files.
 */
#if cpp
import cpp.Prime;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
    
class IOSFiles {
    #if ios
    private static var ios_files_init = Prime._load("iosfiles", "ios_files_init", "vvv", false);
    private static var ios_files_pick_file = Prime._load("iosfiles", "ios_files_pick_file", "v", false);
    private static var ios_files_pick_folder = Prime._load("iosfiles", "ios_files_pick_folder", "v", false);
    private static var ios_files_save = Prime._load("iosfiles", "ios_files_save", "vss", false);
    #end

    public static function setup(onSuccess:String->Void, onCancel:Void->Void):Void {
        #if ios
        ios_files_init(onSuccess, onCancel);
        #end
    }

    public static function pickFile():Void {
        #if ios
        ios_files_pick_file();
        #end
    }

    public static function pickFolder():Void {
        #if ios
        ios_files_pick_folder();
        #end
    }

    public static function saveFile(fileName:String, content:String):Void {
        #if ios
        ios_files_save(fileName, content);
        #end
    }
}
