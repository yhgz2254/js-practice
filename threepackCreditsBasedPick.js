var pack8 = ["p8_1", "p8_2"];
var pack10 = ["p10_1", "p10_2"];
var pack12 = ["p12_1", "p12_2"];
var pack13 = ["p13_1"];
var pack14 = ["p14_1"];

var pick0 = {
	[0] : {
		pack : pack10,
		weight : 9900
	},
	[1] : {
		pack : pack12,
		weight : 90
	},
	[2] : {
		pack : pack13,
		weight : 9
	},
	[3] : {
		pack : pack14,
		weight : 1
	}
}

var pick1 = {
	[0] : {
		pack : pack8,
		weight : 40
	},
	[1] : {
		pack : pack10,
		weight : 59
	},
	[2] : {
		pack : pack12,
		weight : 1
	}
}

var pick2 = {
	[0] : {
		pack : pack12,
		weight : 80
	},
	[1] : {
		pack : pack13,
		weight : 15
	},
	[2] : {
		pack : pack14,
		weight : 5
	}
}

var pickTimes = 0;
var probToSpecial = 0;
var repeat = 5;

for (var i = 0; i < repeat; i++) {
	console.log ("***********************************************");
	var pickToPick = {};
	var name = "";
	if (i == 0) {
		pickToPick = pick0;
	}
	else {
		var probSp = Math.floor(Math.random()*10);
		if (probSp >= probToSpecial) {
			pickToPick = pick2;
		}
		else {
			pickToPick = pick1;
		}
	}

	var prob = Math.floor(Math.random()*getPickWeightTotal(pickToPick));
	// console.log (pickToPick);
	var subTotal = 0;
	for (var i = 0; i < pickToPick.length; i++) {
		if (i != 0) {
			subTotal += pickToPick[i-1].weight;
		}
		if (subTotal >= prob) {
			name = pickToPick[i].pack[Math.floor(Math.random()*pickToPick[i].pack.length)];
			break;
		} 
	}

	console.log (name);
}

function getPickWeightTotal (pack) {
	var total = 0;
	for (var i = 0; i < pack.length; i++) {
		total += pack[i].weight;
	}
	return total;
}
