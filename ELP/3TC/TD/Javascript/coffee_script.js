Counter = () ->
  this.count = 0
  this.tick = () ->
    this.count++
    console.log(this.count)
  return

myCounter = new Counter()

myCounter.tick.bind(myCounter())
myCounter.tick.bind(myCounter())
myCounter.tick.bind(myCounter())
myCounter.tick.bind(myCounter())
