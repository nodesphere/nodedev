// Copyright Chris Larcombe, 2014

var midX, midY;
var screenWidth, screenHeight;

var scene = new Object();


var cache = new Object();
cache.n = new Object();
cache.l = new Object();

//

receiveNodesphere = function(ns)
{

	for (var nid in ns.nodes)
	{

		cache.n[nid] = ns.nodes[nid];

		scene[nid] = new Object();
		scene[nid].x = Math.random()*500 - 250;
		scene[nid].y = Math.random()*500 - 250;
		scene[nid].dx = Math.random()*5 - 2.5;
		scene[nid].dy = Math.random()*5 - 2.5;
	}


	for (var nid in ns.edges)
	{
		cache.l[nid] = ns.edges[nid];

		scene[nid] = new Object();

		// console.log(nid.substr(0,6));

	}

	// console.log(Object.keys(cache.n).length, "nodes in cache");
	// console.log(Object.keys(cache.l).length, "links in cache");

}

//


window.onresize = function()
{
    setCanvasSize();
};

void setCanvasSize()
{
	// Gauge the proper height
	if( jQuery(document).height() > jQuery(window).height() )
	    setupHeight = jQuery(document).height();
	else
	    setupHeight = jQuery(window).height();
	jQuery('canvas').width(jQuery(window).width());
	jQuery('canvas').height(setupHeight);
	size(jQuery(window).width(), setupHeight);

	// Set variables to keep track of midpoint
	midX = jQuery(window).width()/2;
	midY = setupHeight/2;
	
	// Store width and height
	screenWidth = jQuery(window).width();
	screenHeight = setupHeight;
}

void setup()
{
	// Set framerate
	frameTimer = 0;
	resetFrameRate();
	
	// Set initial canvas size
	setCanvasSize();
	
	// Fix 'double-click-lose-focus' bug
	var canvas = document.getElementById('sketch');
	canvas.onselectstart = function () { return false; }
}

void resetFrameRate()
{
	if (frameTimer >= 100)
		frameRate(100);
		
	frameTimer = 0;
}

void draw()
{
	frameTimer++;
	if (frameTimer == 500)
		frameRate(4);

	background(0,0,0);

	stroke(255,255,255, 50);

	for (var nid in cache.l)
	{
		line(
			scene[cache.l[nid].subject].x   + midX, 
			scene[cache.l[nid].subject].y   + midY, 
			scene[cache.l[nid]['object']].x + midX, 
			scene[cache.l[nid]['object']].y + midY
		);
	}

	stroke(0,0,255,200);

	textAlign(CENTER);

	for (var nid in cache.n)
	{

		fill(0,0,255,100);

		ellipse(scene[nid].x + midX, scene[nid].y + midY, 10, 10);
		scene[nid].x += scene[nid].dx * 0.1;
		scene[nid].y += scene[nid].dy * 0.1;


		if (Math.round(Math.random()*50) == 5)
		{
			scene[nid].dx = (Math.random()*5 - 2.5);
			scene[nid].dy = (Math.random()*5 - 2.5);
		}

		fill(255,255,255);

		if (typeof cache.n[nid] == "string")
		{
			text(cache.n[nid], scene[nid].x + midX - 250, scene[nid].y + midY - 20, 500, 100 );
		}

	}

}

void mouseReleased ()
{
	resetFrameRate();
}

void mouseDragged()
{
}

void mousePressed()
{
}

var nlog = function(msg, p1)
{
	if (p1)
		console.log("NODEDEV", msg, p1);
	else
		console.log("NODEDEV", msg);
}
