package iostools.management;

#if cpp
import cpp.Lib;
#end

class Permissions {
    #if ios
    private static var iostools_management_check_camera = Lib.load("iostools", "iostools_management_check_camera", 0);
    private static var iostools_management_request_camera = Lib.load("iostools", "iostools_management_request_camera", 0);
    private static var iostools_management_check_notifications = Lib.load("iostools", "iostools_management_check_notifications", 0);
    private static var iostools_management_request_notifications = Lib.load("iostools", "iostools_management_request_notifications", 0);
    private static var iostools_management_check_files = Lib.load("iostools", "iostools_management_check_files", 0);
    private static var iostools_management_request_files = Lib.load("iostools", "iostools_management_request_files", 0);
    #end

    public static function checkCamera():Int {
        #if ios
        return iostools_management_check_camera();
        #else
        return 0;
        #end
    }

    public static function requestCamera():Void {
        #if ios
        iostools_management_request_camera();
        #end
    }

    public static function checkNotifications():Int {
        #if ios
        return iostools_management_check_notifications();
        #else
        return 0;
        #end
    }

    public static function requestNotifications():Void {
        #if ios
        iostools_management_request_notifications();
        #end
    }

    public static function checkFiles():Int {
        #if ios
        return iostools_management_check_files();
        #else
        return 0;
        #end
    }

    public static function requestFiles():Void {
        #if ios
        iostools_management_request_files();
        #end
    }
}
