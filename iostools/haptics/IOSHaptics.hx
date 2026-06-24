package iostools.haptics;

#if cpp
import cpp.Prime;
#end
 
class IOSHaptics {

    #if ios
    private static var ios_haptics_trigger_impact = Prime._load("ioshaptics", "ios_haptics_trigger_impact", "vi", false);
    private static var ios_haptics_trigger_notification = Prime._load("ioshaptics", "ios_haptics_trigger_notification", "vi", false);
    #end

    public static function light():Void {
        #if ios
        ios_haptics_trigger_impact(0);
        #end
    }

    public static function medium():Void {
        #if ios
        ios_haptics_trigger_impact(1);
        #end
    }

    public static function heavy():Void {
        #if ios
        ios_haptics_trigger_impact(2);
        #end
    }

    public static function success():Void {
        #if ios
        ios_haptics_trigger_notification(0);
        #end
    }

    public static function error():Void {
        #if ios
        ios_haptics_trigger_notification(1);
        #end
    }
}
