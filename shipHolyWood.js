// shipHolyWood.js


// data
var data = {
	holyLevel : 1,
	enhanceCnt : 0,
	critCnt : 0,
	critCntD: 0,
	critCntT: 0,
	attr : 0,
	failure : 0,
	failuresTmp : 0,
	reset : function (argument) {
		this.enhanceCnt = 0,
		this.critCnt = 0,
		this.critCntD = 0,
		this.critCntT = 0,
		this.attr = 0,
		this.failure = 0
	}
}

// var cfg = {
// 	sword : {
// 		1: {Level : 1,maxNum : 300,exchangeRate : 1,initProb : 1,probDecByPts : 100,probDec : 0.015,realProb : 0.95,protectProb : 0.95,protectFailure : 1},		
// 		2: {Level : 2,maxNum : 800,exchangeRate : 1,initProb : 1,probDecByPts : 100,probDec : 0.015,realProb : 0.9,protectProb : 0.9,protectFailure : 2},
// 		3: {Level : 3,maxNum : 1500,exchangeRate : 1,initProb : 0.95,probDecByPts : 100,probDec : 0.01,realProb : 0.8,protectProb : 0.7,protectFailure : 3},
// 		4: {Level : 4,maxNum : 2500,exchangeRate : 1,initProb : 0.9,probDecByPts : 100,probDec : 0.01,realProb : 0.7,protectProb : 0.6,protectFailure : 4},
// 		5: {Level : 5,maxNum : 4000,exchangeRate : 1,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5}
// 	}
// }

var cfg = {
	sword : {
		1: {Level : 1,maxNum : 100,exchangeRate : 5,initProb : 1,probDecByPts : 100,probDec : 0.015,realProb : 0.95,protectProb : 0.95,protectFailure : 1},		
		2: {Level : 2,maxNum : 200,exchangeRate : 5,initProb : 1,probDecByPts : 100,probDec : 0.015,realProb : 0.9,protectProb : 0.9,protectFailure : 2},
		3: {Level : 3,maxNum : 300,exchangeRate : 5,initProb : 0.95,probDecByPts : 100,probDec : 0.01,realProb : 0.8,protectProb : 0.7,protectFailure : 3},
		4: {Level : 4,maxNum : 500,exchangeRate : 5,initProb : 0.9,probDecByPts : 100,probDec : 0.01,realProb : 0.7,protectProb : 0.6,protectFailure : 4},
		5: {Level : 5,maxNum : 1000,exchangeRate : 10,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5},
		6: {Level : 6,maxNum : 1500,exchangeRate : 10,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5},
		7: {Level : 7,maxNum : 2000,exchangeRate : 10,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5},
		8: {Level : 8,maxNum : 3000,exchangeRate : 15,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5},
		9: {Level : 9,maxNum : 4000,exchangeRate : 15,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5},
		10: {Level : 10,maxNum : 5000,exchangeRate : 15,initProb : 0.85,probDecByPts : 100,probDec : 0.01,realProb : 0.6,protectProb : 0.4,protectFailure : 5}
	}
}

function checkFailed() {
	var dice = Math.random ();
	var curCfg = cfg.sword[data.holyLevel];
	var preMaxNum = 0;
	if (cfg.sword[data.holyLevel-1]) {preMaxNum = cfg.sword[data.holyLevel-1].maxNum}
	var curProb = curCfg.initProb - ((curCfg.maxNum - preMaxNum)/curCfg.probDecByPts - 1)*curCfg.probDec;
	if (curProb >= dice) {
		return false;
	}
	if (data.failuresTmp > data.protectFailure) {
		data.failuresTmp = 0;
		return false;
	}
	data.failuresTmp++;
	return true;
}

function getCritProb() {
	var dice = Math.random ();
	// debug_log (getFName(arguments.callee), "dice", dice);
	if (dice <= Math.max((0.6-data.holyLevel*0.10), 0.2)) {
		return true;
	}
	return false;
}

function checkDouble() {
	var dice = Math.random ();
	// debug_log (getFName(arguments.callee), "dice", dice);
	if (dice <= Math.min((0.5+data.holyLevel*0.05), 0.8)) {
		data.critCntD++;
		return true;
	}
	data.critCntT++;
	return false;
}



function onEnhance() {
		if (checkFailed()) {
			data.failure++;
			return 0;
		}
		if (getCritProb()) {
			data.critCnt++;
			if (checkDouble()){
				return 10;
			}
			return 15;
		}
		return 5;
}



for (var i = 0; i < 9; i++) {
	while (data.attr < cfg.sword[data.holyLevel].maxNum) {
		data.attr += onEnhance();
		data.enhanceCnt++;
	}
	console.log ("*************************");
	console.log ("enhanceCnt is " + data.enhanceCnt);
	console.log ("\nattr is " + data.attr);
	console.log ("\ncrit time is " + data.critCnt);
	console.log ("doubling time is " + data.critCntD);
	console.log ("tripling time is " + data.critCntT);
	console.log ("crit rate is " + Math.floor((data.critCnt/data.enhanceCnt)*10000)/100 + "%");
	console.log ("dt rate is " + Math.floor((data.critCntD/data.critCnt)*10000)/100 + "%");
	console.log ("\nfailures are " + data.failure);
	console.log ("failRate is " + Math.floor((data.failure/data.enhanceCnt)*10000)/100 + "%");
	console.log ("\nstone cost are " + (data.enhanceCnt*cfg.sword[data.holyLevel].exchangeRate));
	// console.log ("\n*************************");
	data.reset();
	data.holyLevel++;
}

console.log ("\n*************************");

// console.log ("max is " + cfg.sword[1].maxNum);

// console.log (onEnhance());
// console.log (data);



// tools
function debug_log(func, label, data) {
	console.log("[Debug von func] *" + func + "* " + label + " is " + data);
}

function getFName(fn){
    return (/^[\s\(]*function(?:\s+([\w$_][\w\d$_]*))?\(/).exec(fn.toString())[1] || '';
}