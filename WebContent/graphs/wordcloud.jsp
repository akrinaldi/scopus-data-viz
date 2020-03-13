<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Keywords Cloud</title>
</head>
<body>
<script src="https://d3js.org/d3.v4.js"></script>

<!-- Load d3-cloud -->
<script src="https://cdn.jsdelivr.net/gh/holtzy/D3-graph-gallery@master/LIB/d3.layout.cloud.js"></script>

<!-- Create a div where the graph will take place -->
<div id="mywordcloud"></div>
<script>
var thfill = [
	 "Comparative", "Conflict", "Content analysis", "Economy", "Euro", "European integration", "Framing", "News", "Internet", "media use", "political participation", "youth" ,"Aggression", "Media effects", "Selective exposure", "Violent media content", 
		  "Instructor credibility", "Learning outcomes", "Nonverbal immediacy", "Teacher clarity", "Teacher confirmation","Gender differences", "Internet use", "Life satisfaction", "Pornography", "Sensation seeking" ,"Campaigns", "Message Features", "Message Processing", "Message Sensation Value", "Syntactic Indeterminacy", "Demonstrated Interest", " Responds to Questions", " Teacher Confirmation", "Teacher Power", "Teaching Style", "Perceived Teacher Confirmation", "Perceived Understanding", "Ratings of Instruction" , 
		  "Blog", "Communication technology", "Health communication", "Social support", "Aggression", "Demand/withdraw patterns", "Disclosure", "Feeling caught", "Mental health", "Accuracy", "Deception", "Lies", "Lying", "Truth-bias","Anger", "Persuasion", "Reactance", "Threat to Freedom","Comparative political communication", "Election news coverage", "Framing", "Sweden" ,"Assessment", 
		  "Entertainment media", "Hedonism", "Psychological well-being", "Theory of self-determination", "Framing", "Organ", "Prospect theory", "Psychological reactance", "Reactions" ,"Family Communication", "Information Seeking", "Organ Donation", "Uncertainty" , "Affective learning",
		  "Classroom climate", "College student motivation", "Teacher self-disclosure", "comparative research", "election news", "media interventionism", "mediatization", "attitude", "closeness", "Facebook", "online communication", "social network sites", 
		  "Blog", "Blogging", "Critical", "News technology", "Public relations", "RSS" , "Education", "New media technology", "Practice", "Socialization" ,"Computer experience", "Computer-mediated communication", "Interaction process analysis", "Social information processing",
		  "Socioemotional and task communication", "Video games","Comparative research", "Election news", "Media framing", "Newspapers", "Television news","empathy", "narratives", "news stories", "stigmatization","Communitarianism",
		  "Dialogic", "Dialogue", "Long Now", "Social media", "Technology"
		    ]
	
var margin = {top: 10, right: 10, bottom: 10, left: 10},
width = 3000 - margin.left - margin.right,
height = 3000 - margin.top - margin.bottom;

//append the svg object to the body of the page
var svg = d3.select("#mywordcloud").append("svg")
.attr("width", width + margin.left + margin.right)
.attr("height", height + margin.top + margin.bottom)
.append("g")
.attr("transform",
      "translate(" + margin.left + "," + margin.top + ")")
	.on('dblclick', function(d) {
        console.log('open tab')
        window.open(
          'netzoom.jsp',
          '_blank'
        )
  });

//Constructs a new cloud layout instance. It run an algorythm to find the position of words that suits your requirements
var layout = d3.layout.cloud()
.size([width, height])
.words(thfill.map(function(d) { return {text: d}; }))
.padding(10)
.fontSize(40)
.on("end", draw);
layout.start();

//This function takes the output of 'layout' above and draw the words
//Better not to touch it. To change parameters, play with the 'layout' variable above
function draw(words) {
svg
.append("g")
  .attr("transform", "translate(" + layout.size()[0] / 2 + "," + layout.size()[1] / 2 + ")")
  .selectAll("text")
    .data(words)
  .enter().append("text")
    .style("font-size", function(d) { return d.size + "px"; })
    .attr("text-anchor", "middle")
    .attr("transform", function(d) {
      return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
    })
    .text(function(d) { return d.text; });
}
</script>
</body>
</html>