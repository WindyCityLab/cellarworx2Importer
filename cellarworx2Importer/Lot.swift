import Foundation
public class Lot: PFObject, PFSubclassing
{
    public static func parseClassName() -> String {
        return "Lots"
    }

    //  Strings 
    @NSManaged public var lotnumber : String
    @NSManaged public var the_description : String

    //  Bools
    @NSManaged public var activelot : Bool
    @NSManaged public var favorite : Bool
    @NSManaged public var organic : Bool

    //  Floats

    //  Ints
    @NSManaged public var id : Int
    @NSManaged public var theorder : Int
    @NSManaged public var year : Int
    @NSManaged public var clientcode : Int

    //  Enums

    //  Enum Getters & Setters
    
    // Relationships
    @NSManaged public var client : Client
}
