package iostools.management;

#if cpp
import cpp.Lib;
#end

class Alarms {
    #if ios
    private static var iostools_management_set_alarm = Lib.load("iostools", "iostools_management_set_alarm", 4);
    private static var iostools_management_cancel_alarms = Lib.load("iostools", "iostools_management_cancel_alarms", 0);
    #end

    public static function setAlarm(id:String, title:String, body:String, seconds:Float):Void {
        #if ios
        iostools_management_set_alarm(id, title, body, seconds);
        #end
    }

    public static function cancelAll():Void {
        #if ios
        iostools_management_cancel_alarms();
        #end
    }
}
