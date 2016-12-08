<!DOCTYPE HTML>
<html>
<head>
  <script type="text/javascript">
  window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title:{
      text: "Evening Sales of a Restaurant"
      },

      axisX: {
        valueFormatString: "MMM",
        interval: 1,
        intervalType: "month"
      },

      data: [
      {
        type: "stackedBar",
        legendText: "meals",
        showInLegend: "true",
        dataPoints: [
        { x: new Date(2012, 01, 1), y: 71 },
        { x: new Date(2012, 02, 1), y: 55},
        { x: new Date(2012, 03, 1), y: 50 },
        { x: new Date(2012, 04, 1), y: 65 },
        { x: new Date(2012, 05, 1), y: 95 }

        ]
      },
        {
        type: "stackedBar",
        legendText: "snacks",
        showInLegend: "true",
        dataPoints: [
        { x: new Date(2012, 01, 1), y: 71 },
        { x: new Date(2012, 02, 1), y: 55},
        { x: new Date(2012, 03, 1), y: 50 },
        { x: new Date(2012, 04, 1), y: 65 },
        { x: new Date(2012, 05, 1), y: 95 }

        ]
      },
        {
        type: "stackedBar",
        legendText: "drinks",
        showInLegend: "true",
        dataPoints: [
        { x: new Date(2012, 01, 1), y: 71 },
        { x: new Date(2012, 02, 1), y: 55},
        { x: new Date(2012, 03, 1), y: 50 },
        { x: new Date(2012, 04, 1), y: 65 },
        { x: new Date(2012, 05, 1), y: 95 }

        ]
      },

        {
        type: "stackedBar",
        legendText: "dessert",
        showInLegend: "true",
        dataPoints: [
        { x: new Date(2012, 01, 1), y: 61 },
        { x: new Date(2012, 02, 1), y: 75},
        { x: new Date(2012, 03, 1), y: 80 },
        { x: new Date(2012, 04, 1), y: 85 },
        { x: new Date(2012, 05, 1), y: 105 }

        ]
      },
        {
        type: "stackedBar",
        legendText: "takeaway",
        showInLegend: "true",
        dataPoints: [
        { x: new Date(2012, 01, 1), y: 20 },
        { x: new Date(2012, 02, 1), y: 35},
        { x: new Date(2012, 03, 1), y: 30 },
        { x: new Date(2012, 04, 1), y: 45 },
        { x: new Date(2012, 05, 1), y: 25 }

        ]
      }

      ]
    });

    chart.render();
  }
  </script>
 <script type="text/javascript" src="js/js/canvasjs.min.js"></script>
 </head>
 
<body>
<table><tr><td>
	<div id="chartContainer" style="height: 500px; width: 50%;">
  	</div>
</td></tr></table>
  
</body>
</html>