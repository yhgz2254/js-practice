// var day = 40; 

// var level = -1*Math.pow(10,-9)*Math.pow(day,6) + 5*Math.pow(10,-7)*Math.pow(day,5) - 8*Math.pow(10,-5)*Math.pow(day,4) + 0.0055*Math.pow(day,3) -0.2059*Math.pow(day,2) + 4.1493*day + 27.073;

// var level = 0.0003*Math.pow(day, 3) - 0.0416*Math.pow(day, 2) + 2.1531*day + 31.225;

// console.log (level);


var width = 8;
var height = 5;

var Vector2 = {
	x : 0,
	y : 0,
	hasChar : true,
	ctor : function (x, y) {this.x = x, this.y = y},
	add : function (x, y) {this.x = this.x + x, this.y = this.y + y},
	print : function () {console.log ("this is (" + this.x + ", " + this.y + ")");},
	showme : function () {return ("(" + this.x + ", " + this.y + ")");}
}

var map = new Array();

for (var i = 1; i <= height; i++) {
	for (var j = 1; j <= width; j++) {
		var v = Object.create(Vector2);
		v.ctor (j, i);
		map.push (v);
	}
}

map.forEach (function(p) {
	// p.print();
});

// console.log (map.length);

function debug (s) {
	console.log (s);
}

function FindPath (originPos, tarPos) {
	var curPos = originPos;
	var path = new Array ();
	path.push (originPos);
	var f = 0;
	while (true) {
		var nextPos = FindTileForNextStep (curPos, tarPos);
		path.push (nextPos);
		curPos = nextPos;
		if (curPos.x === tarPos.x && curPos.y === tarPos.y) {break;}
	}
	for (var i = 0; i < path.length; i++) {
		console.log (path[i]);
	}
	return path
}

function FindTileForNextStep (curPos, tarPos) {
	var x = curPos.x - tarPos.x;
	var y = curPos.y - tarPos.y;

	if (NumCompare(Math.abs(x), Math.abs(y))) {
		// return "go horizontally, (" + x/x + ",0)";
		if (x >= 0) {return FindTileByDirection(curPos, "left")}
		else {return FindTileByDirection(curPos, "right")}
	}
	else {
		// return "go vertically, (0," + y/y + ")";
		if (y >= 0) {return FindTileByDirection(curPos, "up")}
		else {return FindTileByDirection(curPos, "down")}
	};
}

function NumCompare (a, b) {
	if (a >= b) {return true;};
	return false;
}

function PosCompare (p1, p2) {
	if (p1.x === p2.x && p1.y === p2.y) {
		return true;
	}
	return false;
}

function FindTileByDirection (pointer, dir) {
	// pointer.print();
	var tar = Object.create(Vector2);
	tar.ctor(pointer.x, pointer.y);
	if (dir === "left") {tar.add(-1, 0)}
	else if (dir === "right") {tar.add(1, 0)}
	else if (dir === "up") {tar.add(0, -1)}
	else if (dir === "down") {tar.add(0, 1)}
	else {return "error"}
	// tar.print ();
	return tar;
}

function FindTilesInCrossField (pointer) {

}

function FindTilesInBufferCrossField (pointer) {

}


// // console.log (Vector2(2, 1).x);
// var p = Object.create(Vector2);
// p.ctor (5, 2);

// console.log (FindTileByDirection(p, "left").print());
// p.print();

var a = Object.create(Vector2); a.ctor (7,2);
var b = Object.create(Vector2); b.ctor (1,1);

console.log ("where to go? " + FindTileForNextStep (a, b));

var mapOnDraw = new Array();

var path = FindPath (a, b);

map.forEach (function(pm) {
	// mapOnDraw.push (pm.showme());
	var isMatch = "nope";
	path.forEach (function (pp) {
		if (PosCompare (pm, pp)) {
			if (PosCompare (pm, a)) {isMatch = "start";}
			else if (PosCompare (pm, b)) {isMatch = "end";}
			else {isMatch = "path"}
		}
	})
	if (isMatch === "start") {
		mapOnDraw.push ("(@@)");
	}
	else if (isMatch === "end") {
		mapOnDraw.push ("(&&)");
	}
	else if (isMatch === "path") {
		mapOnDraw.push ("(<>)");
	}
	else {
		mapOnDraw.push ("(**)");
	}
});

for (var i = 0; i < height; i++) {
	var s = ""
	for (var j = 0; j < width; j++) {
		// debug (j + i*width);
		s += mapOnDraw[j + i*width];
	}
	debug (s);
}