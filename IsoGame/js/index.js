importScripts('Logo.js');

var STR =   "to test fd 1 end";
STR +=      "to setup-rabbit rt 90 activate-daemon daemon-rabbit-eat end";
STR +=      "to setup-robot set-var age 0 activate-daemon daemon-robot-walk end";
STR +=      "to setup-patch set-var age 0 activate-daemon daemon-patch-change end";
STR +=      "to daemon-robot-walk fd 1 rt 1 set-patch-var 9 end";
STR +=      "to daemon-rabbit-eat rt 10 end";
STR +=      "to daemon-patch-change set-var grass 5 end";

var targets = [
	{
		"type":"robot",
		"pos":{
			"x":0,
			"y":0
		},
		"angle":0
	},
	{
		"type":"robot",
		"pos":{
			"x":0,
			"y":0
		},
		"angle":0
	}
];

var patches = [];

var options = {
	consume:function(cmd){
		self.postMessage(JSON.stringify(cmd));
	}
};

self.addEventListener('message', function(e) {
    run(e.data);
}, false);

var stop = function(){
	
};

var run = function(logoString){
	logoString = STR;
	Logo.draw(logoString, options, targets, patches)
	.then(function(){
		console.log('done');
	})
	.catch(function(){
		console.log('error', arguments);
	});
};


