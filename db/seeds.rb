bugs = User.create(username: "space_jam1", password: "bugsisbest")
mj = User.create(username: "LikeMike23", password: "mjgoat")

factory = Restaurant.create(name: "The Carrotcake Factory", cuisine: "Healthy", review: nil, user: bugs)

ccake = Dish.create(name: "Carrot Cake", restaurant: factory)
raw = Dish.create(name: "Raw Carrots", restaurant: factory)
cooked = Dish.create(name: "Cooked Carrots", restaurant: factory)

Visit.create(date: "10 Feb 2021", rating: 3.0, review: "wack", dish: ccake)
Visit.create(date: "11 Feb 2021", rating: 5.0, review: "mediocre", dish: ccake)
Visit.create(date: "12 Feb 2021", rating: 7.0, review: "pretty good", dish: ccake)

Visit.create(date: "13 Feb 2021", rating: 9.0, review: "crunchy and delicious", dish: raw)

Visit.create(date: "14 Feb 2021", rating: 0.5, review: "horrible", dish: cooked)


krus = Restaurant.create(name: "Karrots R Us", cuisine: "Italian", review: "what a great place", user: bugs)

rings = Restaurant.create(name: "646", cuisine: "BBQ", review: "best bbq in town", user: mj)
dd = Restaurant.create(name: "Dunkin Donuts", cuisine: "Breakfast", review: nil, user: mj)

