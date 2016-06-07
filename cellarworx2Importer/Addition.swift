import Foundation
public class Addition: PFObject, PFSubclassing
{
    public static func parseClassName() -> String {
        return "Addition"
    }

    //  Strings 
    @NSManaged public var innoculationbrand : String
    @NSManaged public var labtest : String

    //  Bools

    //  Floats

    //  Ints
    @NSManaged public var bleedamount : Int
    @NSManaged public var brix : Int
    @NSManaged public var dapamount : Int
    @NSManaged public var daycount : Int
    @NSManaged public var goamount : Int
    @NSManaged public var htaamount : Int
    @NSManaged public var id : Int
    @NSManaged public var innoculationamount : Int
    @NSManaged public var superfoodamt : Int
    @NSManaged public var wateramount : Int

    //  Enums

    //  Enum Getters & Setters
}
