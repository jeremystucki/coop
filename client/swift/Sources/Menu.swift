struct Menu {

    let title: String
    let menu: [String]
    let price: Double

    var pretty: String {
        var result = "\(title.bold) \(String(price).bold.blue)\n"

        for item in menu {
            result += "- \(item)\n"
        }

        return result
    }

}
