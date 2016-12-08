
 


var force_color = new Array();
 
var bg_color = new Array();
 
force_color[0]="#d1ffd1";
 
force_color[1]="#ffbbbb";
 
force_color[2]="#ffe3bb";
 
force_color[3]="#cff4f3";
 
force_color[4]="#d9d9e5";
 
force_color[5]="#ffc7ab";
 
force_color[6]="#ecffb7";
 

bg_color[0]="#00ff00";
 
bg_color[1]="#ff0000";
 
bg_color[2]="#ff9900";
 
bg_color[3]="#33cccc";
 
bg_color[4]="#666699";
 
bg_color[5]="#993300";
 
bg_color[6]="#99cc00";
 
line_color="#69f";
 
var left_width=30;
 
var bottom_height=20;
 
function histogram(ar,space,width,height){
 
//柱阴影厚度
 
var thickness = space/2;
 
if (thickness<1)
 
thickness =0;
 
thickness = space;
 
//数据长度
 
var length = ar.length;
 
var iMax=0,iWidth=0,iHeight=0,tMax=0;//数据最大值
 
var i,j,obj,tmp;
 
var index=-1;
 
//验证
 
if (length==0) return;
 
for(i=0;i<length;i++){
 
obj = ar[i].split("|");
 
for(j=0;j<obj.length;j++){
 
tmp = parseInt(obj[j]);
 
if(tmp>iMax)
 
iMax =tmp;
 
}
 
}
 
tmp = iMax+'';
 
j = tmp.length;
 
if(iMax>9){
 
i= parseInt((iMax %100)/10);
 
if(i>4)
 
tMax =(parseInt(iMax/Math.pow(10,(j-1)))+1)*Math.pow(10,j-1);
 
else
 
tMax =(parseInt(iMax/Math.pow(10,(j-1)))+0.5)*Math.pow(10,j-1);
 
}else{
 
if(iMax>4)
 
tMax = 10;
 
else
 
tMax= 5;
 
}
 

document.write('<table width="'+width+'" height="'+height+'" border="0" cellpadding="0" cellspacing="0"><tr>');
 
document.write('<td width="'+left_width+'" align="right" valign="bottom" height="'+(height-bottom_height)+'"><v:line style="position:absolute;left:0px;top:0px;right:0px;"   alt="" to="'+left_width+'px,-'+(height-bottom_height)+'px" from="'+left_width+'px,0px"/>');
 
//画分隔线
 
iMax = 5;
 
tmp = ((height-bottom_height)/iMax);
 
i=1;
 
if(tmp>40){
 
iMax=10;
 
tmp = ((height-bottom_height)/iMax);
 
}
 
while(tmp>40){
 
iMax=10*(i++);
 
tmp = ((height-bottom_height)/iMax);
 
}
 
if(i>1) {
 
iMax-=10;
 
tmp = ((height-bottom_height)/iMax);
 
}
 

document.write("<table width='100%' border='0' cellpadding='0' cellspacing='0' >");
 
for(i=iMax;i>=1;i--){
 
document.write("<tr><td height='"+tmp+"' align='center' style='border-top:1px solid #000000;' valign='top'>"+(tMax/iMax*i)+"</td></tr>");
 
}
 
document.write("</table><v:line to='0px,-"+(height-bottom_height)+"px'/> ");
 

document.write('</td><td   height="'+(height-bottom_height)+'" valign="bottom">');
 
document.write("<v:line   strokecolor='"+line_color+"' to='15px,"+(tmp*(iMax)-15)+"px'   from='15px,0px' />");
 
for(i=0;i<iMax;i++){
 
document.write("<v:line    strokecolor='"+line_color+"' from='0px,"+(tmp*(i+1))+"'   to='15px,"+(tmp*(i+1)-15)+"px' />");
 
document.write("<v:line   strokecolor='"+line_color+"' to='15px,"+(tmp*(i+1)-15)+"'   from='"+(width-left_width)+"px,"+(tmp*(i+1)-15)+"' />");
 
}
 
document.write('<v:rect   alt="" style="position:absolute;width:'+(width-left_width)+';height:'+(height-bottom_height)+';z-index:-9" fillcolor="#9cf" stroked="f"><v:fill rotate="t" angle="-45" focus="100%" type="gradient"/></v:rect>');
 
document.write('<table width="100%"   border="0" cellspacing="0" cellpadding="0"><tr><td width="'+left_width/2+'"></td>');
 
//柱状图
 
tmp = (width-2*left_width)/length;
 
index = (height-bottom_height)/tMax;
 
for(i=0;i<length;i++){
 
obj = ar[i].split("|");
 
document.write("<td valign='bottom'   width='"+tmp+"' align='center' height='"+(height-bottom_height)+"'>");
 
document.write('<v:group ID="group1" style="position:relative;WIDTH:'+tmp+'px;HEIGHT:'+(height-bottom_height)+'px;" coordsize = "'+tmp*10+','+(height-bottom_height)*10+'">');
 
document.write("<v:textbox style='position:absolute;left:0;top:-15;' inset='0px,0px,0px,0px' ><table cellspacing='3' cellpadding='0' width='100%' height='100%'><tr><td align='center'>"+formatNumber(obj[1],2)+"</td></tr></table></v:textbox>");
 
document.write('<v:rect style="position:relative;width:'+(tmp-space/2-15)*10+';height:'+index*parseInt(obj[1])*10+';" fillcolor="'+bg_color[i%bg_color.length]+'">');
 
//if(index*parseInt(obj[1])>10)
 

document.write("<v:fill style='position:relative;' color2='"+force_color[i%force_color.length]+"' rotate='t' type='gradient'/>");
 
document.write("<o:extrusion v:ext='view'   style='position:relative;' backdepth='"+thickness+"px' color='"+bg_color[i%bg_color.length]+"' on='t'/>");
 
document.write('</v:rect>');
 
document.write('</v:group>');
 
document.write("</td>");
 
}
 
document.write('</tr></table>');
 
//document.write('</v:rect>');
 

document.write('</td></tr><tr><td   height="'+bottom_height+'"></td>');
 
document.write('<td valign="bottom" height="'+bottom_height+'" width="'+(width-left_width)+'" style="border-top:1px solid #000000" >');
 
document.write('<table width="100%"   border="0" cellspacing="0" cellpadding="0"><tr><td width="'+left_width/2+'"></td>');
 
for(i=0;i<length;i++){
 
obj = ar[i].split("|");
 
document.write("<td   width='"+tmp+"' align='center'>"+obj[0]+"</td>");
 
}
 
document.write('</td></tr></table>');
 
document.write('</td></tr></table>');
 
}
 

function formatNumber(obj,length){
 
if(isNaN(obj)) return obj;
 
var tmp=obj+'';
 
var index = tmp.indexOf(".");
 
if(index!=-1){
 
return obj.substring(0,index+3);
 
}
 
else
 
return obj;
 

}
 


 

