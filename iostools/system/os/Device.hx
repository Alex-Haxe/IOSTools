package iostools.system.os;
// only ios 14 to higher are supported. tho ill maybe make a legacy one for old ios

enum IOSVersion {
    IOS14;
    IOS15;
    IOS16;
    IOS17;
    IOS18;
    IOS19;
    IOS20;
    IOS21;
    IOS22;
    IOS23;
    IOS24;
    IOS25;
    IOS26;
    IOS27;
    UNKNOWN;
}

class Device {
    
    /**
     * Retrieves the hardware model identifier.
     */
    public static function getModel():String {
        #if ios
        return iostools_device_get_model();
        #else
        return "Unknown";
        #end
    }

    /**
     * Retrieves the operating system version as a string.
     */
    public static function getSystemVersion():String {
        #if ios
        return iostools_device_get_system_version();
        #else
        return "0.0";
        #end
    }

    /**
     * Retrieves the operating system name.
     */
    public static function getSystemName():String {
        #if ios
        return iostools_device_get_system_name();
        #else
        return "Unknown";
        #end
    }

    /**
     * Retrieves the custom user-assigned name of the device.
     */
    public static function getName():String {
        #if ios
        return iostools_device_get_name();
        #else
        return "Unknown";
        #end
    }

    /**
     * Retrieves the parsed major version of the current operating system and maps it to the IOSVersion enum.
     */
    public static function getMajorVersion():IOSVersion {
        var versionStr = getSystemVersion();
        var major = Std.parseInt(versionStr.split(".")[0]);
        
        return switch (major) {
            case 14: IOS14;
            case 15: IOS15;
            case 16: IOS16;
            case 17: IOS17;
            case 18: IOS18;
            case 19: IOS19;
            case 20: IOS20;
            case 21: IOS21;
            case 22: IOS22;
            case 23: IOS23;
            case 24: IOS24;
            case 25: IOS25;
            case 26: IOS26;
            case 27: IOS27;
            default: UNKNOWN;
        }
    }

    #if ios
    private static var iostools_device_get_model = cpp.Lib.load("iostools", "iostools_device_get_model", 0);
    private static var iostools_device_get_system_version = cpp.Lib.load("iostools", "iostools_device_get_system_version", 0);
    private static var iostools_device_get_system_name = cpp.Lib.load("iostools", "iostools_device_get_system_name", 0);
    private static var iostools_device_get_name = cpp.Lib.load("iostools", "iostools_device_get_name", 0);
    #end
}
