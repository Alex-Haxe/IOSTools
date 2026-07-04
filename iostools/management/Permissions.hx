package iostools.management;

#if cpp
import cpp.Lib;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class Permissions {
    #if ios
    private static var iostools_management_check_camera = Lib.load("iostools", "iostools_management_check_camera", 0);
    private static var iostools_management_request_camera = Lib.load("iostools", "iostools_management_request_camera", 0);
    private static var iostools_management_check_notifications = Lib.load("iostools", "iostools_management_check_notifications", 0);
    private static var iostools_management_request_notifications = Lib.load("iostools", "iostools_management_request_notifications", 0);
    private static var iostools_management_check_files = Lib.load("iostools", "iostools_management_check_files", 0);
    private static var iostools_management_request_files = Lib.load("iostools", "iostools_management_request_files", 0);
    #end

    public static function checkCameraPermission():Int {
        #if ios
        return iostools_management_check_camera();
        #else
        return 0;
        #end
    }

    public static function requestCameraPermission():Void {
        #if ios
        iostools_management_request_camera();
        #end
    }

    public static function checkNotificationsPermission():Int {
        #if ios
        return iostools_management_check_notifications();
        #else
        return 0;
        #end
    }

    public static function requestNotificationsPermission():Void {
        #if ios
        iostools_management_request_notifications();
        #end
    }

    public static function checkFilesPermission():Int {
        #if ios
        return iostools_management_check_files();
        #else
        return 0;
        #end
    }

    public static function requestFilesPermission():Void {
        #if ios
        iostools_management_request_files();
        #end
    }
}
