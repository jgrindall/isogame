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
	Logo.stop();
};

var run = function(data){
	data = JSON.parse(data);
	Logo.draw(data.logo, data.targets, data.patches, consumer)
	.then(function(){
		consumer.consume({"type":"done", "msg":""});
		console.log('done');
	})
	.catch(function(){
		consumer.consume({"type":"error", "msg":""});
		console.log('error', arguments);
	});
};

var setDelay = function(d){
	Logo.setDelay(parseInt(d));
};
