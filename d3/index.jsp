<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Network graph</title>
<style>
.link {
fill:none;
stroke: #AAA;

}

.node circle {
stroke:#FFF;
stroke-width:3px;
}
</style>
</head>
<body>
<div id="myDiv">
  <h2>Network of Journalism Studies coauthorship</h2>
  <p>Hover for author name</p>
  <p>Double click for author stats</p>
</div>
<svg>
</svg>
<script src="https://d3js.org/d3.v3.js"></script>
<!-- <script src="https://github.com/d3/d3-plugins/blob/master/fisheye/fisheye.js"></script> -->
<script>

// set things up!
var height = 1700;
var width = 2000;

var svg = d3.select("body")
	.append("svg")
	.attr("width", width)
	.attr("height", height);
	
// var fisheye = d3.fisheye.circular()
// .radius(200)
// .distortion(2);	

var force = d3.layout.force()
	.gravity(0.50)
	.distance(0)
	.charge(-100)
	.size([width,height])
	;
	
// cookbookd3forcegraph above

// data = d3.json("Access-Control-Allow-Origin: http://wintermute.slis.uiowa.edu:8081/journalism/abby/coauthorData.jsp");


// var data = d3.json("Access-Control-Allow-Origin: http://wintermute.slis.uiowa.edu:8081/journalism/abby/coauthorData.jsp"); 

var color = d3.scale.category10();

d3.json("coauthorsnew.jsp", function(json) {
	force
		.size([width,height])
		.nodes(json.nodes)
		.links(json.links)
		.start()
		;

	
	var link = svg.selectAll(".link")
		.data(json.links)
		.enter()
		.append("line")
		.attr("class", "link")
		.style("stroke-width", function(d) {return d.value +3})
		.style("fill","black")
	;
	
	var node = svg.selectAll(".node")
		.data(json.nodes)
		.enter()
		.append("g")
		.attr("class", "node")
		.call(force.drag)
		.on('dblclick', function(d) {
    console.log('open tab')
    window.open(
      'table.jsp',
      '_blank'
		)})
	;
    
		
		node.append("circle")
		.attr("r", function(d) {return d.score + 10})
		.classed('selected', function(d) { return d._selected; })
		.style('fill', function (d)
                {return color(d.group)});
		
		node.append("title")
		.attr("dx",12)
		.attr("dy",12)
		.text(function(d) {return [d.name, d.group]});
		
	
		//d3 fisheye
		
force.on("tick", function() {
	link.attr("x1", function(d) { return d.source.x;})
		.attr("y1", function(d) { return d.source.y;})
		.attr("x2", function(d) { return d.target.x;})
		.attr("y2", function(d) { return d.target.y;});
	node.attr("transform", function(d) {
		return "translate("+ d.x +", "+ d.y +")"; });	
	
});

});

// svg.on("mousemove", function() {
// 	  fisheye.focus(d3.mouse(this));

// 	  node.each(function(d) { d.fisheye = fisheye(d); })
// 	      .attr("cx", function(d) { return d.fisheye.x; })
// 	      .attr("cy", function(d) { return d.fisheye.y; })
// 	      .attr("r", function(d) { return d.fisheye.z * 4.5; });

// 	  link.attr("x1", function(d) { return d.source.fisheye.x; })
// 	      .attr("y1", function(d) { return d.source.fisheye.y; })
// 	      .attr("x2", function(d) { return d.target.fisheye.x; })
// 	      .attr("y2", function(d) { return d.target.fisheye.y; });
// 	});

//Buttons


// 10 members for new cutoff net graph

</script>


</body>
</html>