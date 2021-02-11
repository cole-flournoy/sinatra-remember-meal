bugs = User.create(username: "space_jam1", password: "bugsisbest")
mj = User.create(username: "LikeMike23", password: "mjgoat")

factory = Restaurant.create(name: "The Carrotcake Factory", cuisine: "Healthy", user: bugs)

ccake = Dish.create(name: "Carrot Cake", restaurant: factory)
raw = Dish.create(name: "Raw Carrots", restaurant: factory)
cooked = Dish.create(name: "Cooked Carrots", restaurant: factory)

Visit.create(date: Date.yesterday, rating: 3.0, review: "wack", dish: ccake)
Visit.create(date: Date.today, rating: 5.0, review: "mediocre", dish: ccake)
Visit.create(date: Date.today, rating: 7.0, review: "pretty good", dish: ccake)




krus = Restaurant.create(name: "Karrots R Us", cuisine: "Italian", user: bugs)

rings = Restaurant.create(name: "646", cuisine: "BBQ", user: mj)
dd = Restaurant.create(name: "Dunkin Donuts", cuisine: "Breakfast", user: mj)

