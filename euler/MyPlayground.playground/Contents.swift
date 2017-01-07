import Foundation

let formatter = DateFormatter()
formatter.dateFormat = "MM/dd/yyyy"

let date = formatter.date(from: "11/**asdojn/1989")
let string = formatter.string(from: date)


