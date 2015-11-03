
function additionneur(x) {
  return function (a) { return a + x }
}

var plusDeux = additionneur(2);
var plusTrois = additionneur(3);

  console.log (plusDeux(10))
console.log (plusTrois(2))
