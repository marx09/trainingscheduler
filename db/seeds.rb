Excercise.create!([
  {name: "Kliky", description: "", reverse_weight: false},
  {name: "Drepy", description: "", reverse_weight: false},
  {name: "Shyby", description: "", reverse_weight: false},
  {name: "Sklapovacky", description: "", reverse_weight: false}
])
Group.create!([
  {name: "SA"},
  {name: "first group"},
  {name: "second group"},
  {name: "third group"},
  {name: "fourth group"},
  {name: "fifth group"},
  {name: "sixth group"},
  {name: "seventh group"},
  {name: "eight group"},
  {name: "nineth group"},
  {name: "tenth group"}
])
Training.create!([
  {date: "2016-01-20", from: "2000-01-01 07:00:00", to: "2000-01-01 08:00:00", training_prototype_id: 3},
  {date: "2016-01-22", from: "2000-01-01 07:00:00", to: "2000-01-01 08:00:00", training_prototype_id: 4},
  {date: "2016-01-19", from: "2000-01-01 08:00:00", to: "2000-01-01 09:00:00", training_prototype_id: 5},
  {date: "2016-01-19", from: "2000-01-01 19:00:00", to: "2000-01-01 20:00:00", training_prototype_id: 1},
  {date: "2016-01-21", from: "2000-01-01 19:00:00", to: "2000-01-01 20:00:00", training_prototype_id: 2}
])
TrainingPrototype.create!([
  {day: 1, from: "2000-01-01 19:00:00", to: "2000-01-01 20:00:00", group_id: 1},
  {day: 3, from: "2000-01-01 19:00:00", to: "2000-01-01 20:00:00", group_id: 1},
  {day: 2, from: "2000-01-01 07:00:00", to: "2000-01-01 08:00:00", group_id: 2},
  {day: 4, from: "2000-01-01 07:00:00", to: "2000-01-01 08:00:00", group_id: 2},
  {day: 1, from: "2000-01-01 08:00:00", to: "2000-01-01 09:00:00", group_id: 3}
])
