var origin = {
	a : "sida",
	b : 2,
	c : function (argument) {
		return "c";
	}
}

var s = JSON.stringify(origin);

console.log (s);

var final = JSON.parse(s);

console.log (final);