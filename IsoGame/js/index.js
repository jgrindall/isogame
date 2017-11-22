

if(!console || !console.log){
	if(consoleLog){
		console = {
			log: consoleLog
		}
	}
}

function check(a){
	console.log("args!!! ", a);
}

console.log("loaded");


var STR =   "to test fd 1 end";

STR +=      "to setup-rabbit rt 90 activate-daemon daemon-rabbit-eat end";

STR +=      "to setup-robot set-var age 0 test end";

STR +=      "to setup-rabbit rt 90 activate-daemon daemon-rabbit-eat end";

STR +=      "to setup-robot set-var age 0 setxy 0 0 end";

STR +=      "to setup-patch set-var age 0 activate-daemon daemon-patch-change end";

STR +=      "to daemon-robot-walk fd 1 set-patch-var 9 end";

STR +=      "to daemon-rabbit-eat rt 10 end";

STR +=      "to daemon-patch-change set-var grass 5 end";

console.log("b2");

var targets = [
			   {"type":"robot", "pos":{"x":0, "y":0}, "angle":0},
			   {"type":"robot", "pos":{"x":0, "y":0}, "angle":0}
			   ];

var patches = [];

console.log(Logo);

Logo.draw(STR, {consume:function(cmd){
    if(cmd.type === "command"){
		  console.log('cmd', cmd);
    }
    else if(cmd.type === "error"){
		  console.log("ERROR", cmd);
    }
		  }}, targets, patches)
.then(function(){
	  console.log('done');
	  })
.catch(function(){
    console.log('error', arguments);
	   });

console.log("b3");

setTimeout(function(){
    console.log("to");
}, 2000);
