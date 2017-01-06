
function redTwo (total, num) {
	var list = [];
	var resultList = [];
	var sumList = 0;
	for (var i = 0; i < num; i++) {
		list[i] = parseInt(Math.random()*(9999) + 1, 10);
		sumList += list[i];
	}

	var sumResult = 0;
	for (var i = 0; i < list.length; i++) {
		var tmpp = Math.floor(list[i]*total/sumList);
		if (tmpp <= 0) {
			tmpp = 1;
		}
		if (tmpp >= 50) {
			tmpp = 50;
		}
		sumResult += tmpp;
		resultList[i] = tmpp;
	}

	resultList[0] += total - sumResult;
	return resultList;
}

var check = 0;
var min = 20;
var max = 0;
var min0 = 0
for (var j = 0; j < 100000; j++) {
	var result = redTwo(200, 15);
	var tmpTotal = 0;
	for (var i = 0; i < result.length; i++) {
		tmpTotal += result[i];
		if (result[i] > max) {
			max = result[i];
		}
		if (result[i] < min) {
			min = result[i];
		}
	}
	if (tmpTotal != 200) {
		check++;
	}
	if (min == 0) {
		// console.log ("0!!!!!");
		// console.log (result);
		min0++;
	}
}
console.log (check);
console.log ("min is " + min);
console.log ("max is " + max);