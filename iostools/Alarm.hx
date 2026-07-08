package iostools;

#if cpp
import cpp.Lib;
#end

@:buildXml('<include name="${haxelib:IOSTools}/project/Build.xml" />')
class Alarm {
    #if ios
    private static var iostools_management_set_alarm = Lib.load("iostools", "iostools_management_set_alarm", 4);
    private static var iostools_management_cancel_alarms = Lib.load("iostools", "iostools_management_cancel_alarms", 0);
    #end

    public static function set(id:String, title:String, body:String, seconds:Float):Void {
        #if ios
        try {
            iostools_management_set_alarm(id, title, body, seconds);
        } catch (e:Dynamic) {
            trace("Failed to schedule alarm: " + e);
        }
        #end
    }

    public static function cancelAll():Void {
        #if ios
        try {
            iostools_management_cancel_alarms();
        } catch (e:Dynamic) {
            trace("Failed to cancel alarms: " + e);
        }
        #end
    }
}
