<%@ page import="com.lakala.java.config.LakalPayConfig" %>
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
    <title>拉卡拉跨境支付参数配置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta charset="utf-8">
</head>
<style>
    html, body {
        width: 100%;
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
        width: 8em;
        display: block;
        color: #00afec;
        font-size: 1.5em;
    }

    #env:hover {
        background-color: #00afef;
        color: #FFFFFF;
    }

    .container form {
        width: 100%;
        height: 100%;
        margin: 5em auto;
        font-family: "Lantinghei SC", "Open Sans", Arial, "Hiragino Sans GB", "Microsoft YaHei", STHeiti, "WenQuanYi Micro Hei", SimSun, sans-serif;
    }

    .envOpt {
        width: 80em;
        height: 1.5em;
        margin: 0.5em auto;
    }

    .bizfield {
        width: 80em;
        height: auto;
        margin: 2em auto;
    }

    .keys {
        border: 1px solid rgb(0, 175, 236);
        margin: 0px;
        width: 60em;
    }

    form div label {
        width: 12em;
        float: left;
        text-align: right;
        line-height: 24px;
    }

    form div input {
        width: 20em;
        border-color: #00afef;
        border-width: 0.1em;
        border-style: solid;
        height: 24px;

    }

    .submit {
        display: block;
        height: 3em;
        margin: 2em auto;
        background-color: #FFFFFF;
        border-color: #00afef;
        -moz-transition: all 0.5s linear;
        -webkit-transition: all 0.5s linear;
        -o-transition: all 0.5s linear;
        transition: all 0.1s linear;
    }

    .envradio {
        float: left;
    }

    .submit:hover {
        background-color: #00afef;
        color: #FFFFFF;
    }

    @media screen and (max-width: 436px) {
        .container {
            width: 100%;
            height: 100%;
        }

        .container form {
            width: 100%;
            height: 100%;
        }

        form div label {
            width: 10em;
            text-align: left;
        }

        .envOpt {
            width: 100%;
        }

        .bizfield {
            width: 100%;
        }

        form div input {
            width: 100%;
        }

        .keys {
            width: 100%;
        }

    }

    @media screen and (max-width: 320px) {
        .container {
            width: 100%;
            height: 100%;
        }

        .container form {
            width: 100%;
            height: 100%;
        }

        form div label {
            width: 10em;
            text-align: left;
        }

        .envOpt {
            width: 100%;
        }

        .bizfield {
            width: 100%;
        }

        form div input {
            width: 100%;
        }

        .keys {
            width: 100%;
        }

    }
</style>
<body>
<div class="header">
    <div class="left">
        <a href="<%=request.getContextPath()%>"> <img src="<%=request.getContextPath()%>/img/logo.png"></a>
    </div>
</div>
<div class="container">
    <span id="desc">请选设置接入参数</span>

    <form action="envConfig.jsp" method="post">
        <div class="envOpt">
            <label> 联调环境：</label><input class="envradio" type="radio" name="env"
                                        value="0" style="width: 1em;"

            <%
                if(LakalPayConfig.LKL_HOST.equals("http://testintl.lakala.com") ){
                        out.print("checked=\"checked\"");
                }

            %>
                >
        </div>
        <div class=" envOpt">
            <label> 生产环境：</label><input type="radio" name="env"
                                        value="1" style="width: 1em;"
            <%
                                        if(LakalPayConfig.LKL_HOST.equals("https://intl.lakala.com")){
                                        out.print("checked=\"checked\"");
                                        }

            %>>
        </div>

        <div class="envOpt">
            <label> 恢复默认设置：</label><input class="envradio" type="radio" name="env"
                                          value="2" style="width: 1em;"
                >
        </div>

        <div class="bizfield">
            <label> 商户号：</label><input type="textarea" name="merId" placeholder="<%=LakalPayConfig.getMerchantNo()%>"
                                       value="<%=LakalPayConfig.getMerchantNo()%>" required
                                       aria-required="true">
        </div>

        <div class="bizfield">
            <label> 公钥：</label><textarea class="keys" name="pubKey" cols=120
                                         rows=4><%=LakalPayConfig.getPubKey()%></textarea>

            <%--<label> 公钥：</label><input type="text" name="merId" placeholder="<%=LakalPayConfig.getPrivateKey()%>"--%>
            <%--value="<%=LakalPayConfig.getPrivateKey()%>" required--%>
            <%--aria-required="true">--%>
        </div>

        <div class="bizfield">
            <label> 私钥：</label><textarea class="keys" name="prvKey" cols=120
                                         rows=12><%=LakalPayConfig.getPrivateKey()%></textarea>

            <%--<input type="text" name="merId" placeholder="<%=LakalPayConfig.getPrivateKey()%>"--%>
            <%--value="<%=LakalPayConfig.getPrivateKey()%>" required--%>
            <%--aria-required="true">--%>
        </div>
        <div class="bizfield">
            <input class="submit" type="submit" value="确认修改">
        </div>
    </form>
</div>
</body>
</html>
