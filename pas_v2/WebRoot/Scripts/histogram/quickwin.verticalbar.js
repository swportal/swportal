/***************************************
//Y轴
//ctx: Canvas 2D context
//maxAmount: 数据的最大值
//interval: 每一刻度代表的数值
****************************************/
function verticalbar(ctx, maxAmount, interval) {

    this.ctx = ctx;
    this.maxAmount = maxAmount;
    this.interval = interval;
};

verticalbar.prototype.draw = function () {

    //计算需要绘制几个刻度
    var segmentcount = Math.ceil(this.maxAmount / this.interval);

    //Y轴的高度
    var height = segmentcount * 50;

    //绘制Y轴
    this.ctx.beginPath();
    this.ctx.lineWidth = 1;
    this.ctx.strokeStyle = "#999999";
    this.ctx.moveTo(50, this.ctx.canvas.clientHeight - 50);
    this.ctx.lineTo(50, this.ctx.canvas.clientHeight - 50 - height - 20);
    this.ctx.stroke();

    //绘制刻度数
    this.ctx.font = "12px Arial";
    this.ctx.textAlign = "end";
    this.ctx.fillText("0", 40, this.ctx.canvas.clientHeight - 50);    
    for (var j = 1; j < segmentcount + 1; j++) {

        this.ctx.fillText(this.interval * j, 40, this.ctx.canvas.clientHeight - 20 - (j - 1) * 50 - 70);
    }
    
};