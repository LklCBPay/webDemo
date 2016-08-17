<%--
  author jiangzhifei
  email:jiangzhifei@lakala.com
  Date: 16/8/10
  Time: 11:00
  说明：该demo只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html>
<head>
    <title>拉卡拉跨境支付</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta charset="utf-8">
</head>
<style>
    html, body {
        width: 100%;
        /*min-width: 1200px;*/
        height: 100%;
        padding: 0;
        margin: 0;
        font-family: "微软雅黑";
    }

    .header {
        width: 100%;
        height: 5em;
        top: 0px;
        background-color: #FFFFFF;
        -moz-box-shadow: 0px 1px 8px gray;
        -webkit-box-shadow: 0px 1px 8px gray;
        box-shadow: 0px 1px 8px gray;
        position: fixed;
    }

    .left {
        width: 15em;
        height: auto;
        margin-left: 2em;
        margin-top: 0.8em;
        margin-right: 10em;
        padding-right: 0em;
        float: left;
    }

    .container {
        height: auto;
        top: 6em;
        margin-top: 6em;
    }

    #desc {
        margin: 0 auto;
        width: 7em;
        display: block;
        color: #00afec;
        font-size: 1.5em;
    }

    .menu {
        width: 32em;
        height: 25em;
        margin: 4em auto;

    }

    .item:hover {
        -moz-box-shadow: 0px -1px 8px #00afec;
        -webkit-box-shadow: 0px -1px 8px #00afec;
        box-shadow: 0px -1px 8px #00afec;

    }

    .item {
        border: 1px solid #00afec;
        float: left;
        width: 15em;
        height: 25em;
        margin-left: 0.5em;
        text-align: center;

        -moz-transition: all 0.4s linear;
        -webkit-transition: all 0.4s linear;
        -o-transition: all 0.4s linear;
        transition: all 0.4s linear;
    }

    .item h1 {
        margin-top: 3em;
        color: #00afec;

        -moz-transition: all 0.5s linear;
        -webkit-transition: all 0.5s linear;
        -o-transition: all 0.5s linear;
        transition: all 0.5s linear;
    }

    .item a {
        text-decoration: none;
        color: gray;
        margin: 8px auto;
        display: block;

        -moz-transition: all 0.1s linear;
        -webkit-transition: all 0.1s linear;
        -o-transition: all 0.1s linear;
        transition: all 0.1s linear;
    }

    .item a:hover {
        color: #00afef;

        -moz-transform: scale(1.4);
        -webkit-transform: scale(1.5);
        -o-transform: scale(1.4);
        transform: scale(1.4);
    }

    .item p {
        height: auto;
        margin: 3em auto;
        line-height: 1.5em;
        color: gray;
    }

    #env {
        width: 8em;
        line-height: 2em;
        color: #00afef;
        border-style: solid;
        border-width: 1px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        -o-border-radius: 4px;
        border-radius: 4px;
        margin: 0 auto;
        text-align: center;
        font-family: "Lantinghei SC", "Open Sans", Arial, "Hiragino Sans GB", "Microsoft YaHei", STHeiti, "WenQuanYi Micro Hei", SimSun, sans-serif;
    }

    #env:hover {
        background-color: #00afef;
        color: #FFFFFF;
    }
</style>
<body>
<div class="header">
    <div class="left">
        <a target="_blank" href="http://intl.lakala.com"> <img src="<%=request.getContextPath()%>/img/logo.png"></a>
    </div>
</div>
<div class="container">
    <span id="desc">请选择接入类型</span>

    <div class="menu">
        <div class="item pc">
            <h1>PC终端接入</h1>

            <p>
                <a href="pc/pc_quickpay.jsp">境内快捷</a>
                <a href="pc/pc_ds.jsp">境内代收</a>
                <a href="pc/pc_kj_quickpay.jsp">跨境快捷</a>
                <a href="pc/pc_kj_ds.jsp">跨境代收</a>
            </p>
        </div>

        <div class="item mobile">
            <h1>移动终端接入</h1>

            <p>
                <a href="mob/mob_quickpay.jsp">境内快捷</a>

                <a href="mob/mob_ds.jsp"> 境内代收</a>

                <a href="mob/mob_kj_quick.jsp">跨境快捷</a>

                <a href="mob/mod_kj_ds.jsp">跨境代收</a>
            </p>
        </div>
    </div>
    <a style="text-decoration: none;" href="env.jsp">
        <div id="env"> 设置接入参数</div>
    </a>
</div>
</body>
</html>
