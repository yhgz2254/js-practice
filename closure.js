var o = function (x) {
	var base = x;
	console.log (base);
	return function (n) {
		return base + n;
	}
}

var oo = o (10);


console.log (oo (10));

console.log (oo (10));

o.p;