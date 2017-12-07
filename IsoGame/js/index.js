importScripts('Logo.js');

var consumer = {
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
	data = JSON.parse(data);
	Logo.draw(data.logo, data.targets, data.patches, consumer)
	.then(function(){
		console.log('done');
	})
	.catch(function(){
		console.log('error', arguments);
	});
};

var setDelay = function(d){
	Logo.setDelay(parseInt(d));
};
