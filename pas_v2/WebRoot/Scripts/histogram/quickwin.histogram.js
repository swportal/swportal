/***************************************
//ctx: Canvas 2D context
//data: json 数据
//yInterval: Y轴一刻度的数值
****************************************/
function histogram(ctx, data, yInterval) {

    this.ctx = ctx;

    //Json数据
    this.data = data;    

    //Y轴一刻度的数值
    this.yInterval = yInterval;
};
 

histogram.prototype.draw = function () {

    
    //柱状图标题
     var title = this.data.title;

    //Y轴标题
     var verticaltitle = this.data.verticaltitle;

    //X轴标题
     var horizontaltitle = this.data.horizontaltitle;

    //颜色
    var colors = ["#3366FF", "#FFCC00"];


    var dataarray = this.data.data;
    var dataCollection;
    var metaData;    
    
    var maxamount = 0;
    var categoryCount = dataarray.length;
    var dataCount = dataarray[0].datacollection.length;
    
    //找出最大的数值，以便绘制Y轴的刻度。
    for (var i = 0; i < dataarray.length; i++) {

        dataCollection = dataarray[i].datacollection;
        for (var j = 0; j < dataCollection.length; j++) {
            
            metaData = dataCollection[j];
            maxamount = (new Number(metaData.amount) > maxamount) ? metaData.amount : maxamount;

            //alert(maxamount);
        }
    }

    
    //动态设置 canvas 的尺寸
   this.ctx.canvas.height = Math.ceil(maxamount / this.yInterval) * 50 + 120;    //120 is for the chart title.
    this.ctx.canvas.width = categoryCount * dataCount * 30 + dataCount*30  + 150;  //150 is for right side index 
    

    var vbar = new verticalbar(this.ctx, maxamount, this.yInterval);
    var hbar = new horizontalbar(this.ctx, categoryCount, dataCount);

    //绘制 x 轴和 y 轴
    vbar.draw();
    hbar.draw();

    //绘制标题
    this.ctx.font = "bold 16px Arial";
    this.ctx.textAlign = "center";
    this.ctx.fillText(title, this.ctx.canvas.width/2,25);
    
    //绘制Y轴标题
    this.ctx.font = "12px Arial";
    this.ctx.textAlign = "center";
    this.ctx.fillText(verticaltitle, 50, 40);
   
    //绘制X轴标题
    this.ctx.font = "12px Arial";
    this.ctx.fillText(horizontaltitle, this.ctx.canvas.width - 47, this.ctx.canvas.height - 46);

    //绘制柱
    this.ctx.lineWidth = 30;
    var x = 80;
    var y = this.ctx.canvas.clientHeight;
    
    for (var i = 0; i < dataarray.length; i++) {

        dataCollection = dataarray[i].datacollection;
        this.ctx.beginPath();
        this.ctx.strokeStyle = colors[i]; 

        for (var j = 0; j < dataCollection.length; j++) {
           
            metaData = dataCollection[j];
            this.ctx.moveTo(x, y - 50-1);
            this.ctx.lineTo(x, y - 50 - 1 - (metaData.amount / vbar.interval) * 50 +5);
            this.ctx.stroke();

            //绘制柱的金额
            this.ctx.font = "10px Arial";this.ctx.textAlign = "start";
            this.ctx.fillText(metaData.amount, x - 12, y - 50 - 1 - (metaData.amount / vbar.interval) * 50);

            //绘制柱的标题
            this.ctx.font = "12px Arial";            
            this.ctx.fillText(metaData.title, x-12 , y - 30);

            x += (categoryCount * 30 + 30);
        }

        x = 80 + 30 * (i + 1);       

    }

    //绘制右上角的标识器
    this.ctx.lineWidth = 15;    
    for (var i = 0; i < dataarray.length; i++) {
        
        this.ctx.beginPath();
        this.ctx.strokeStyle = colors[i];
        this.ctx.moveTo(this.ctx.canvas.width-80, 50+i*17);
        this.ctx.lineTo(this.ctx.canvas.width - 65, 50 + i * 17);
        this.ctx.font = "12px Arial";
        this.ctx.textAlign = "left";
        this.ctx.fillText(dataarray[i].category, this.ctx.canvas.width - 60, 50 + i * 17+4);
        this.ctx.stroke();
    }
    
}

 