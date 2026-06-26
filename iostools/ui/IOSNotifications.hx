package iostools.ui;

#if cpp
import cpp.Prime;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class IOSNotifications {

    #if ios
    private static var ios_notifications_request_permission = Prime._load("iosnotifications", "ios_notifications_request_permission", "v", false);
    private static var ios_notifications_send_notification = Prime._load("iosnotifications", "ios_notifications_send_notification", "vss", false);
    #end

    public static function requestPermission():Void {
        #if ios
        ios_notifications_request_permission();
        #end
    }

    public static function send(title:String, body:String):Void {
        #if ios
        ios_notifications_send_notification(title, body);
        #end
    }
}
