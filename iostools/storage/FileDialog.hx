package iostools.storage;

#if cpp
import cpp.Lib;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class FileDialog {
    #if ios
    private static var ios_files_init = Lib.load("iosfiles", "ios_files_init", 2);
    private static var ios_files_pick_file = Lib.load("iosfiles", "ios_files_pick_file", 0);
    private static var ios_files_pick_folder = Lib.load("iosfiles", "ios_files_pick_folder", 0);
    private static var ios_files_save = Lib.load("iosfiles", "ios_files_save", 2);
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
