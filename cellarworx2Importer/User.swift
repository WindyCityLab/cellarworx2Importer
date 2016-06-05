import Foundation
public class User: PFUser
{
    public enum carrierEnum : Int {
        case att
        case verizon
        case sprint
        case tmobile
    }

    //  Strings 
    @NSManaged public var cellphone : String
    @NSManaged public var deviceid : String
    @NSManaged public var name : String

    //  Bools
    @NSManaged public var staffEnum : Bool

    //  Floats

    //  Ints
    @NSManaged public var clientid : Int
    @NSManaged public var group : Int
    @NSManaged public var id : Int

    //  Enums
    @NSManaged private var carrier_p : Int // carrierEnum
    @NSManaged private var staff_p : Int // staffEnum

    //  Enum Getters & Setters

    public var carrier : carrierEnum {
        get {
            return carrierEnum(rawValue : carrier_p)!
        }
        set {
            carrier_p = newValue.rawValue
        }
    }
    
    @NSManaged public var client : Client
}
