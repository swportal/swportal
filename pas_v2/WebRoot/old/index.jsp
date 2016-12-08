<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO8859-1" />
    <title>CSS + DIV 让页脚始终底部</title>
    <meta name="generator" content="" />
<style type="text/css">

body{
    margin:0;
    padding:0;
    font:12px/1.5 tahoma,arial,'Hiragino Sans GB',\5b8b\4f53,sans-serif;
    
    position:absolute;width:100%;min-height:100%; 
    
    
}


 .content{
    padding-bottom: 54px;
 }
 
 
a:link,a:visited,a:active{color:#00749E;text-decoration:none;}
a:hover{color:#000;text-decoration:underline;}
 
#header{width:980px;height:69px;margin:0 auto;padding:0;}
#header h1.blogtitle{font-family:Arial, Helvetica, sans-serif;margin:0;padding:10px 0 0;}
#header p.desc{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;margin:0;padding:0;}
#top{background-color:#fff;background-image:url(images/topbck.gif);background-repeat:repeat-x;height:34px;}
 
#ddnav{background-color:#312e2e;height:35px;margin:0;padding:0;}
#nav{height:25px;width:980px;font-weight:700;margin:0 auto;padding:10px 0 0;}
ul.nav{height:25px;line-height:25px;float:left;list-style:none;font-size:11px;text-transform:inherit;margin:0;padding:0;}
ul.nav li{float:left !important;list-style-type:none;border-right:2px solid #312e2e;margin:0;padding:0;}
ul.nav li a,ul.nav li a:link,ul.nav li a:visited{background:url(images/navsilver.gif) repeat-x;color:#818181;float:left;display:block;text-decoration:none;padding:0 15px;}
ul.nav li a:hover,ul.nav li a:active {background:url(images/navblue.gif) repeat-x;color:#205387;text-decoration:none;}
ul.nav li.current_page_item a{text-decoration:none;background:url(images/navblue.gif) repeat-x;color:#fff;}
ul.nav li ul{float:left;margin:0;padding:0;}

#footer{background-image:url(images/footerbck.gif);background-repeat:repeat-x;clear:both;height:24px;margin:0;padding:0;position:absolute;bottom:30px;width:100%;}
#footerbox{color:#fff;background-color:#312e2e;height:30px;line-height:30px !important;margin:0;padding:0;clear:both;position:absolute;bottom:0px;width:100%;}
.footer{width:980px;color:#fff;height:30px;line-height:30px !important;margin:0 auto;padding:0;}
.footer a:hover{text-decoration:underline;color:#fff;border:none;}
.footer a:link,.footer a:active,.footer a:visited{text-decoration:underline;color:#25aacd;border:none;}

#top{background-color:#fff;background-image:url(images/topbck.gif);background-repeat:repeat-x;height:34px;}
 
</style>

<script type="text/javascript">
function aboutFunc(){
window.document.getElementById("about").style.display="";
}

function indexFunc(){
window.document.getElementById("about").style.display="none";
}

</script>
</head>
<body>

<div id="header">
        <h1 class="blogtitle">
        <a href="http://www.cnblogs.com/chenyuming507950417/">助你软件工作室</a>
    </h1>
    <p class="desc">二十八年，我用青春修行</p>
</div>


<div id="ddnav">
        <div id="nav">
        <ul class="nav">
            <li><a href="#" onclick="indexFunc();">主页</a></li>
        </ul>
        <ul class="nav">
            <li><a href="#" onclick="aboutFunc();">关于</a></li>
        </ul>
    </div>
</div>

 <div id="top">
    </div>


<div class="content">
    <div id="post-e0a6ac53-c204-4919-9fda-2021397c40b8">

            <p><p class="MsoNormal" style="margin-bottom: 7.5pt; text-align: center; mso-pagination: widow-orphan;" align="center">
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">麦子，你是怎样长进我的眼睛</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span>
            </strong><strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你站立的土地一直站着我的双脚</span>
            </strong><strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我们同根而生，是伙伴</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">只是我比你在泥土上住得更久</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我一辈子是生活的奴隶，为了生计</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">一年一次，我用锋利的镰刀收割</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你的麦芒对着天，从没刺伤我</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">为让我拿镰的手有更多的力气</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你在一盘磨里走很长的路</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">把自己碾的粉身碎骨</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我是在饥饿时学会了感恩</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">端起一碗饭就想你熟了的肤色</span>
            </strong><strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">想起在泥土上来回行走的季节</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">麦子，你年年回来吧，我年年爱你</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"></span></strong>
            </p></p>
            
        </div>
        
        <div id="about" style="display:none;">

            <p><p class="MsoNormal" style="margin-bottom: 7.5pt; text-align: center; mso-pagination: widow-orphan;" align="center">
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">麦子，你是怎样长进我的眼睛</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span>
            </strong><strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你站立的土地一直站着我的双脚</span>
            </strong><strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我们同根而生，是伙伴</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">只是我比你在泥土上住得更久</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我一辈子是生活的奴隶，为了生计</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">一年一次，我用锋利的镰刀收割</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你的麦芒对着天，从没刺伤我</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">为让我拿镰的手有更多的力气</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">你在一盘磨里走很长的路</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">把自己碾的粉身碎骨</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">我是在饥饿时学会了感恩</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">端起一碗饭就想你熟了的肤色</span>
            </strong><strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">想起在泥土上来回行走的季节</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"><br /> </span></strong>
            <strong><span style="font-size: 14pt; font-family: 宋体;" lang="ZH">麦子，你年年回来吧，我年年爱你</span></strong>
            <strong><span style="font-size: 14pt; font-family: Arial;" lang="EN-US"></span></strong>
            </p></p>
            
        </div>

</div>

<div id="footer">
</div>
<div id="footerbox">
    <div class="footer">
        <a href="http://www.cnblogs.com/chenyuming507950417/">助你软件工作室</a>&nbsp;&nbsp;&nbsp; 二十八年，我用青春修行&nbsp;&nbsp;&nbsp; &copy; Copyright
    </div>
</div>
    
<body>
</html>