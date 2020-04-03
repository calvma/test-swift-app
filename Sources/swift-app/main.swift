import PerfectMySQL

let testHost = "127.0.0.1"
let testUser = "root"
let testDB = "nadja"

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
// Prints "120"
print(statistics.2)
// Prints "120"

func fetchData() {
    let mysql = MySQL()
    let connected = mysql.connect(host: testHost, user: testUser, db: testDB)
    guard connected else {
        print(mysql.errorMessage())
        return
    }
    defer {
        mysql.close()
    }
    let sql = """
    SELECT * FROM interactions;
    """
    guard mysql.query(statement: sql) else {
        print(mysql.errorMessage())
        return
    }
    let results = mysql.storeResults()!

    print(results.numRows())
//    var ary = [[String:Any]]()
//    results.forEachRow { row in
//       let optionName = getRowString(forRow: row[0]) //Store our Option Name, which would be the first item in the row, and therefore row[0].
//       let optionValue = getRowString(forRow: row[1]) //Store our Option Value
//       ary.append("\(optionName)":optionValue]) //store our options
//   }
//    print("Final Array \(ary)")

}

fetchData()
