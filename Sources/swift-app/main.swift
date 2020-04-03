import PerfectMySQL

// manually created testDB in mysql cmd prompt
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

    let insert_sql = """
    INSERT INTO interactions (name) VALUES ("transaction_from_swift")
    """
    guard mysql.query(statement: insert_sql) else {
        print(mysql.errorMessage())
        return
    }

    let select_sql = """
    SELECT * FROM interactions;
    """
    guard mysql.query(statement: select_sql) else {
        print(mysql.errorMessage())
        return
    }
    let select_results = mysql.storeResults()!
    print(select_results.numRows())

    var ary = [[String:Any]]()
    select_results.forEachRow { row in
        ary.append(["name": row[0] ?? "nil"])
   }
    print("Final Array \(ary)")

}

fetchData()
