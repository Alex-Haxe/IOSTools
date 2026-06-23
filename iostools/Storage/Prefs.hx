package iostools.storage;

#if cpp
import cpp.Lib;
#end

class Prefs {
    #if ios
    private static var iostools_storage_save_string = Lib.load("iostools", "iostools_storage_save_string", 2);
    private static var iostools_storage_get_string = Lib.load("iostools", "iostools_storage_get_string", 1);
    private static var iostools_storage_save_bool = Lib.load("iostools", "iostools_storage_save_bool", 2);
    private static var iostools_storage_get_bool = Lib.load("iostools", "iostools_storage_get_bool", 1);
    #end

    public static function saveString(key:String, value:String):Void {
        #if ios
        iostools_storage_save_string(key, value);
        #end
    }

    public static function getString(key:String):String {
        #if ios
        return iostools_storage_get_string(key);
        #else
        return "";
        #end
    }

    public static function saveBool(key:String, value:Bool):Void {
        #if ios
        iostools_storage_save_bool(key, value);
        #end
    }

    public static function getBool(key:String):Bool {
        #if ios
        return iostools_storage_get_bool(key);
        #else
        return false;
        #end
    }
}
