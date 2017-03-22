import Vapor

let drop = Droplet()

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"

    return try drop.view.make("hello", [
        "name":name
    ])
}

drop.run()
