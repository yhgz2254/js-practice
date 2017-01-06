// // bossBefallProb.js

// Level 30

// var cntTotal = 0;
// var cntTime = 10000;

// for (var j = 0; j < cntTime; j++) {
// 	var maxCourage = 83;

// 	var purchace = 8;
// 	var purchaseCourage = 50*purchace;

// 	var probBase = 1,
// 		probGrowth = 0.05,
// 		probGrowthByCourage = 15;

// 	var courageCost = 0;

// 	var speedUpCost = [8, 18, 10];

// 	var courage = maxCourage + purchaseCourage;

// 	var suTime = 0;

// 	var cardCnt = 0;

// 	for (var i = 0; i < 100; i++) {
// 		// console.log ("This is the " + i + " times speed-up, current courage is " + courage + ".. And courage already cost is " + courageCost);
// 		courage = courage - speedUpCost[suTime];
// 		courageCost = courageCost + speedUpCost[suTime];
// 		var prob  = Math.random ();
// 		// console.log ("The card-up prob we got this time is -- " + prob + ".. And probBase now is -- " + probBase);
// 		if (prob <= probBase) {
// 			probBase = 0;
// 			cardCnt++;
// 		}
// 		else {
// 			probBase = probBase + (speedUpCost[suTime]/probGrowthByCourage)*probGrowth;
// 		}
// 		if (suTime = 2) {
// 			suTime = 0;
// 		}
// 		else {
// 			suTime++;
// 		}
// 		if (courageCost >=  maxCourage + purchaseCourage) {break;}
// 		// console.log ("****====================****====================****");
// 	}

// 	// console.log ("Card got -- " + cardCnt);
// 	cntTotal += cardCnt;
// }

// console.log ("Avg num " + cntTotal/cntTime);

// console.log ((""+{}+{}).length);

console.log ({}.toString);