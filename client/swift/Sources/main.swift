#if os(Linux)
import Glibc
#else
import Darwin
#endif

let api = try CoopAPI()
let usage = "Usage: coop [ locations | menus <location> ]"

if CommandLine.arguments.count == 1 {
    print(usage)
    exit(0)
}

if CommandLine.arguments[1].lowercased() == "locations" {
    print(api.getLocations().joined(separator: "\n"))
} else if CommandLine.arguments[1].lowercased() == "menus" && CommandLine.arguments.count > 2 {
    api.getMenus(forLocation: CommandLine.arguments[2]).forEach({ print($0.pretty) })
} else {
    print(usage)
}
