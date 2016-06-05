import Foundation
public class Client: CellarworxClass, PFSubclassing
{
    public static func parseClassName() -> String {
        return "Client"
    }

    //  Strings 
    @NSManaged public var address1 : String
    @NSManaged public var address2 : String
    @NSManaged public var bond : String
    @NSManaged public var city : String
    @NSManaged public var clientname : String
    @NSManaged public var code : String
    @NSManaged public var group : String
    @NSManaged public var phone : String
    @NSManaged public var state : String
    @NSManaged public var zip : String

    //  Bools
    @NSManaged public var active : Bool
    @NSManaged public var ap : Bool

    //  Floats

    //  Ints
    @NSManaged public var clientid : Int

    //  Enums

    //  Enum Getters & Setters
}
