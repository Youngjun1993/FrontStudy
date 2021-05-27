
exports.evenHap = function(maxNum){
	var evenHap=0;
	var tot=1;
	for(tot; tot<=maxNum; tot++){
		if(tot % 2 == 0){
			evenHap += tot;
		}
	}
	return "1~"+maxNum+"까지의 홀수 합은 "+evenHap+"이다.";
}

exports.oddHap = function(maxNum){
	var oddHap=0;
	var tot=1;
	for(tot; tot<=maxNum; tot++){
		if(tot % 2 == 1){
			oddHap += tot;
		}
	}
	return "1~"+maxNum+"까지의 홀수 합은 "+oddHap+"이다.";
}

exports.hap = function(maxNum){
	var hap=0;
	var tot=1;
	for(tot; tot<=maxNum; tot++){
		hap += tot;
	}
	return "1~"+maxNum+"까지의 홀수 합은 "+hap+"이다.";
}