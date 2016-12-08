/***************************************
//X轴
//ctx: Canvas 2D context
//categoryCount: 数据的分类
//dataCount: 每一分类的数据样本数
****************************************/
function horizontalbar(ctx, categoryCount, dataCount) {

    this.ctx = ctx;
    this.categoryCount = categoryCount;
    this.dataCount = dataCount;
};

horizontalbar.prototype.draw = function () {
        
    //计算X轴的长度
    var width = this.categoryCount * this.dataCount * 30 + this.dataCount*30;
   
    //绘制X轴
    this.ctx.beginPath();
    this.ctx.lineWidth = 1;
    this.ctx.strokeStyle = "#999999";
    this.ctx.moveTo(50, this.ctx.canvas.clientHeight - 50);
    this.ctx.lineTo(50+width, this.ctx.canvas.clientHeight - 50);
    this.ctx.stroke();

};