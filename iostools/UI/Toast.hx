package iostools.ui;

#if cpp
import cpp.Lib;
#end

class Toast {
    #if ios
    private static var iostools_ui_show_toast = Lib.load("iostools", "iostools_ui_show_toast", 1);
    #end

    public static function show(message:String):Void {
        #if ios
        iostools_ui_show_toast(message);
        #end
    }
}
