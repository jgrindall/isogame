importScripts('Logo.js');

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

var run = function(data){
	self.postMessage("data" + data);
	data = JSON.parse(data);
	self.postMessage(1 + " : " + JSON.stringify(data.logo));
	self.postMessage(2 + " : " + JSON.stringify(data.targets));
	self.postMessage(3 + " : " + JSON.stringify(data.patches));
	Logo.draw(data.logo, data.targets, data.patches, options)
	.then(function(){
		console.log('done');
	})
	.catch(function(){
		console.log('error', arguments);
	});
};


