import UIKit

// When creating a model we have multiple options and one of the most used ones is a struct
// Example:

struct Session {
    let title: String
    let speaker: String
    let date: Date
    let isKeyNote: Bool
    let isWorkShop: Bool
    let isRecorded: Bool
    let isJointSession: Bool
    let jointSpeakers: [String]
}

// Now when we create an object for the session this is how its created
let session = Session(title: "WWDC Main Event", speaker: "Tim Cook", date: Date(), isKeyNote: true, isWorkShop: false, isRecorded: true, isJointSession: false, jointSpeakers: [])

// But this can be easily created using enums
// Enums are very cheap to create and they provide much more flexibility and structure
// Example:

enum SessionWithEnum {
    case isKeyNote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case isWorkshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case isJointSession(title: String, speaker: String, date: Date, isRecorded: Bool, jointSpeakers: [String])
}

let sessionWithEnum = SessionWithEnum.isKeyNote(title: "WWDC", speaker: "Tim Cook", date: Date(), isRecorded: true)

func displaySession(session: SessionWithEnum) {
    switch session {
    case .isKeyNote(title: let title, speaker: let speaker, date: let date, isRecorded: let isRecorded):
        print("Session Info: \(title), \(speaker), \(date), \(isRecorded)")
    case .isJointSession(title: let title, speaker: let speaker, date: let date, isRecorded: let isRecorded, jointSpeakers: let jointSpeakers):
        print("Session Info: \(title), \(speaker), \(date), \(isRecorded), \(jointSpeakers)")
    default:
        print("Session is Default")
    }
}

displaySession(session: sessionWithEnum)

// As we see, in the above example the Enums come in handy when creating
// large models or representing data when it comes to multiple types
// While using enums we can also use default types and only implement the types we need




/*
 *********************************************************************************
 *********************************************************************************
 */
print("")
print("")
print("*********************************************************************************")
print("*********************************************************************************")

/*
 While using hetrogenous collections when using structs to define types. We face
 a problem in which we have to keep the collection as Any and implement checks for
 each type seperately.
 */

struct Teacher {
    let name: String
    let courses: [String]
}

struct Student {
    let name: String
    let courses: [String]
    var grade: String?
}

let teacher = Teacher(name: "Usman", courses: ["OOP", "Data Structures", "LA"])
var student = Student(name: "Osama", courses: ["OOP"], grade: "A+")

let users: [Any] = [student, teacher]

for user in users {
    switch user {
    case let user as Teacher:
        print("Grade is: \(user.courses)")
    case let user as Student:
        print("Grade is: \(user.grade ?? "")")
    default:
        print("Not Student or Teacher")
    }
}

/*
 As implemented above we can see that we have to check for the type for each element of
 the collection and also a default case because we are expecting a collection of type Any.
 This can be resolved by using enums. This also constitutes polymorphism with Enums in Swift
 */

enum User {
    case teacher(Teacher)
    case student(Student)
}

let usersHetro: [User] = [.student(student), .teacher(teacher)]

for user in usersHetro {
    switch user {
    case .teacher(let teacher):
        print("Grade is: \(teacher.courses)")
    case .student(let student):
        print("Grade is: \(student.grade ?? "")")
    }
}

/*
 *********************************************************************************
 *********************************************************************************
 */
print("")
print("")
print("*********************************************************************************")
print("*********************************************************************************")

/*
 This is a common way to deal with Types with common base functionality. However, this
 approach creates problems when we are scaling and more types are being added. So we can
 use enums for the same problem as given in the next problem.
 */

class Ticket {
    var departure: String
    var arrival: String
    var price: String
    
    init(departure: String, arrival: String, price: String) {
        self.departure = departure
        self.arrival = arrival
        self.price = price
    }
}

class Business: Ticket {
    var meal: String
    var drinks: String
    
    init(departure: String, arrival: String, price: String, meal: String, drinks: String) {
        self.meal = meal
        self.drinks = drinks
        super.init(departure: departure, arrival: arrival, price: price)
    }
}

class BusinessEconomy: Ticket {
    var meal: String
    
    init(departure: String, arrival: String, price: String, meal: String) {
        self.meal = meal
        super.init(departure: departure, arrival: arrival, price: price)
    }
}


class Economy: Ticket {
    
}

func checkIn(ticket: Ticket) {
    switch ticket {
    case let ticket as Business:
        print("Business")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
        print("Meal: \(ticket.meal)")
        print("Drinks: \(ticket.drinks)")
    case let ticket as BusinessEconomy:
        print("BusinessEconomy")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
        print("Meal: \(ticket.meal)")
    case let ticket as Economy:
        print("Economy")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
    default:
        print("Some Other: \(ticket)")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
    }
}

checkIn(ticket: BusinessEconomy(departure: "02:00+05:00", arrival: "05:00+05:00", price: "Rs: 7,000/-", meal: "Sandwich"))

/*
 *********************************************************************************
 *********************************************************************************
 */
print("")
print("")
print("*********************************************************************************")
print("*********************************************************************************")

/*
 Resolving the problem in the way below, There is no base class so any changes arent effecting
 other types. Also there is no need of hardcoding type checks for switch cases. And scalability
 get way more easy.
 */

struct SuperBusiness {
    var departure: String
    var arrival: String
    var price: String
    var drinks: String
    var meal: String
}

struct SuperBusinessEconomy {
    var departure: String
    var arrival: String
    var price: String
    var meal: String
}

struct SuperEconomy {
    var departure: String
    var arrival: String
    var price: String
}

enum SuperTicket {
    case business(SuperBusiness)
    case businessEconomy(BusinessEconomy)
    case economy(Economy)
}

func superLoungeCheckIn(ticket: SuperTicket) {
    switch ticket {
    case .business(let ticket):
        print("Business")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
        print("Meal: \(ticket.meal)")
        print("Drinks: \(ticket.drinks)")
    case .businessEconomy(let ticket):
        print("Business Economy")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
        print("Meal: \(ticket.meal)")
    case .economy(let ticket):
        print("Economy")
        print("Departure: \(ticket.departure)")
        print("Arrival: \(ticket.arrival)")
    }
}

let ticket = SuperTicket.business(SuperBusiness(departure: "02:00+05:00", arrival: "05:00+05:00", price: "Rs: 7,000/-", drinks: "Cold & Hot", meal: "Sandwich"))
superLoungeCheckIn(ticket: ticket)
