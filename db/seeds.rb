bugs = User.create(username: "space_jam1", password: "bugsisbest")
mj = User.create(username: "LikeMike23", password: "mjgoat")

factory = Restaurant.create(name: "The Carrotcake Factory", cuisine: "Healthy", user: bugs)
ccake = Dish.create(name: "Carrot Cake" , date: Date.today , rating: 5.5, restaurant: factory)
raw = Dish.create(name: "Raw Carrots" , date: Date.yesterday, rating: 9.0, restaurant: factory)
cooked = Dish.create(name: "Cooked Carrots", date: Date.tomorrow, rating: 0.1, restaurant: factory)


krus = Restaurant.create(name: "Karrots R Us", cuisine: "Italian", user: bugs)

rings = Restaurant.create(name: "646", cuisine: "BBQ", user: mj)
dd = Restaurant.create(name: "Dunkin Donuts", cuisine: "Breakfast", user: mj)

