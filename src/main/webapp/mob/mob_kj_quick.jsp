<%--
  author: jiangzhifei
  email:jiangzhifei@lakala.com
  Date: 16/8/10
  Time: 17:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="com.lakala.java.config.LakalPayConfig" %>
<%@ page import="com.lakala.java.util.DateUtil" %>
<html>
<head>
    <title>移动终端</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <style>
        html, body {
            width: 100%;
            height: auto;
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

        .headerleft {
            width: 25em;
            height: auto;
            margin-left: 60%;
            margin-right: 10%;
            margin-top: 1em;
        }

        .headerleft h1 {
            display: inline-block;
            margin: 0;
        }

        .headerleft h2 {
            display: inline-block;
            margin: 0;
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
            margin-top: 6em;
            margin-bottom: 6em;
            margin-left: 6em;
            width: auto;
            height: auto;
        }

        .side h1 {
            color: gray;
            width: auto;
            margin: 0;
            margin-left: 1em;
            margin-right: 0.5em;
            padding: 0;
        }

        .container form {
            width: 80em;
            height: 100%;
            margin: 0em auto;
            font-family: "Lantinghei SC", "Open Sans", Arial, "Hiragino Sans GB", "Microsoft YaHei", STHeiti, "WenQuanYi Micro Hei", SimSun, sans-serif;
        }

        .bizfield {
            width: 100%;
            height: 1.5em;
            margin-top: 0.5em;
        }

        .remark {
            float: left;
            margin-left: 1em;
            color: lightcoral;
            font-size: 0.8em;
            font-style: italic;
            width: auto;
        }

        form div label {
            width: 12em;
            float: left;
            text-align: right;
            line-height: 24px;
        }

        form div input {
            width: 20em;
            float: left;
            border-color: #00afef;
            border-width: 0.1em;
            border-style: solid;
            height: 24px;

        }

        form div select {
            width: 20em;
            float: left;
            border-color: gray;
            border-width: 0.1em;
            height: 2em;
        }

        .submit {
            margin-left: 5em;
            margin-top: 3em;
            /*margin-bottom: 3em;*/
            position: relative;
            background-color: #FFFFFF;
            border-color: #00afef;
            -moz-transition: all 0.5s linear;
            -webkit-transition: all 0.5s linear;
            -o-transition: all 0.5s linear;
            transition: all 0.1s linear;
        }

        .submit:hover {
            background-color: #00afef;
            color: #FFFFFF;
        }

        .side h3 {
            color: gray;
            width: auto;
            margin: 0;
            margin-left: 5em;
            margin-top: 1.5em;

            -moz-transition: all 0.5s linear;
            -webkit-transition: all 0.5s linear;
            -o-transition: all 0.5s linear;
            transition: all 0.1s linear;
        }

        .side h3:hover {
            color: #00afef;
        }

        .side a {
            text-decoration: none;
        }

        @media screen and (max-width: 436px) {
            html, body {
                width: 100%;
                height: 100%;
            }

            .headerleft {
                display: none;
            }

            .container {
                width: 100%;
                height: 100%;
                margin-bottom: 0em;
                margin-left: 0em;
            }

            .container form {
                width: 100%;
                height: 100%;
            }

            .bizfield {
                height: 5em;
            }

            form div label {
                text-align: left;
            }

            form div input {
                width: 100%;
            }

            .remark {
                margin-left: 0em;
            }

            .submit {
                margin-left: 0em;
                margin-top: 0em;
                background-color: #00afef;
                color: #FFFFFF;
            }

            form div select {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="left">
        <a href="<%=request.getContextPath()%>"> <img src="<%=request.getContextPath()%>/img/logo.png"></a>
    </div>
    <div class="headerleft"><h1>移动接入网关——</h1>

        <h2>跨境快捷</h2></div>

</div>
</body>
<div class="container">
    <form action="../pay.jsp" method="post">
        <%--交易请求的uri--%>
        <div class="bizfield" style="display: none">
            <input type="text" name="requestUri" hidden="hidden"
                   value="ppayGate/CrossBorderHtml5Pay.do">
        </div>
        <div class="bizfield">
            <label>协议版本号：</label><input type="text" name="ver" value="1.0.0" required aria-required="true"
                                        readonly/><label
                class="remark">必填，默认为1.0.0</label>
        </div>
        <div class="bizfield">
            <label> 请求业务类型：</label><input type="text" name="reqType" value="B0002" required aria-required="true"><label
                class="remark">必填，参见接口文档中请求业务类型字段</label>
        </div>
        <div class="bizfield">
            <label> 商户号：</label><input type="text" name="merId" placeholder="<%=LakalPayConfig.getMerchantNo()%>"
                                       value="<%=LakalPayConfig.getMerchantNo()%>" required
                                       aria-required="true"><label
                class="remark">必填，商户在拉卡拉跨境开设的商户号</label>
        </div>
        <div class="bizfield">
            <label> 支付方式：</label><select id="payTypeId" name="payTypeId" placeholder="1" required aria-required="true"
                                         value="1">
            <option value="1">1-快捷</option>
            <option value="4">4-代收</option>
        </select>
            <label
                    class="remark">必填</label>
        </div>
        <div class="bizfield">
            <label> 跨境业务类型：</label>
            <select id="busiRange" name="bizCode" required aria-required="true">
                <option value="121010">121010 货物贸易</option>
                <option value="222024">222024 航空机票</option>
                <option value="223022">223022 留学教育</option>
                <option value="223023">223023 留学教育</option>
                <option value="223029">223029 酒店住宿</option>
                <option value="223029">223029 酒店住宿</option>
                <option value="228025">228025 国际展览</option>
            </select>
            <label class="remark">根据商户需求自行选择</label>
        </div>

        <div class="bizfield">
            <label> 时间戳：</label><input type="text" name="ts" value="<%=DateUtil.getCurrentTime()%>"
                                       required aria-required="true" readonly>
            <label class="remark">必填，时间戳,格式:yyyyMMddHHmmssssssss</label>
        </div>

        <div class="bizfield">
            <label> 商户订单号：</label><input type="text" name="merOrderId" value=""
                                         placeholder="tmp<%=DateUtil.getCurrentTime()%>"
                                         required aria-required="true">
            <label class="remark">必填，商户订单号，保证唯一,长度不超过64位</label>
        </div>

        <div class="bizfield">
            <label> 订单币种：</label><select id="currency" name="currency" value=""
                                         placeholder="CNY"
                                         required aria-required="true">
            <option value="CNY">CNY-人民币</option>
            <option value="USD">USD-美元</option>
            <option value="HKD">HKD-港币</option>
            <option value="EUR">EUR欧元</option>
            <option value="JPY">JPY-日元</option>
            <option value="GBP">GBP-英镑</option>
            <option value="CHF">CHF-瑞士法郎</option>
            <option value="SGD">SGD-新加坡元</option>
            <option value="AUD">AUD-澳元</option>
            <option value="CAD">CAD-加元</option>
            <option value="KRW">KRW-韩元</option>
            <option value="MYR">MYR-马来西亚林吉特</option>
            <option value="NZD">NZD-新西兰</option>
            <option value="RUB">RUB-卢布</option>
            <option value="THB">THB-泰铢</option>
            <option value="TWD">TWD-新台币</option>
        </select>
            <label class="remark">必填，订单币种，境内为CNY。支持币种见LklCurrency.java</label>
        </div>

        <div class="bizfield">
            <label> 订单金额：</label><input type="text" name="orderAmount" value=""
                                        placeholder="123.22"
                                        required aria-required="true"
                                        pattern="^(([1-9]\d{0,9})|0)(\.\d{1,2})">
            <label class="remark">必填，订单金额，单位元，保留小数点后两位</label>
        </div>

        <div class="bizfield">
            <label> 订单概要：</label><input type="text" name="orderSummary" value="">
            <label class="remark">必填.商品种类-订单信息。商品种类为：国际展览,酒店住宿,留学教育,货物贸易,航空机票,其他；</label>
        </div>
        <div class="bizfield">
            <label> 商户会员ID：</label><input type="text" name="customNumberId" value="NA">
            <label class="remark">必填 无会员填写“NA”</label>
        </div>
        <div class="bizfield">
            <label> 订单日期：</label><input type="text" name="orderTime"
                                        value=""
                                        placeholder="<%=DateUtil.getCurrentDate("yyyyMMddHHmmss")%>"
                                        required aria-required="true">
            <label class="remark">必填，订单日期，格式为yyyyMMddHHmmss</label>
        </div>

        <div class="bizfield">
            <label> 订单有效日期：</label><input type="text" name="orderEffTime"
                                          value=""
                                          placeholder="<%=DateUtil.getCurrentDate("yyyyMMddHHmmss")%>"
                                          required aria-required="true">
            <label class="remark">必填，订单有效日期，格式为yyyyMMddHHmmss</label>
        </div>

        <div class="bizfield">
            <label> 时区：</label><input type="text" name="timeZone"
                                      value=""
                                      placeholder="GMT+8"
                                      required aria-required="true">
            <label class="remark">必填，时区，默认GMT+8：东8区</label>
        </div>

        <div class="bizfield">
            <label> 前台通知地址：</label><input type="url" name="pageUrl"
                                          value="http://testintl.lakala.com:8080/webDemo/pageNotify.jsp"
                                          placeholder="http://商户网址/pageNotify.jsp">
            <label class="remark">商户接受拉卡拉支付结果的url</label>
        </div>
        <div class="bizfield">
            <label> 后台通知地址：</label><input type="url" name="bgUrl"
                                          value="http://testintl.lakala.com:8080/webDemo/returnNotify.jsp"
                                          placeholder="http://商户网址/returnNotify.jsp">
            <label class="remark">商户接受拉卡拉异步支付结果的url。前台与后台通知地址，二者必选其一，可同时填写</label>
        </div>
        <div class="bizfield">
            <label> 扩展字段1：</label><input type="text" name="ext1"
                                         value="">
            <label class="remark"> 扩展字段1</label>
        </div>
        <div class="bizfield">
            <label> 扩展字段2：</label><input type="text" name="ext2"
                                         value="">
            <label class="remark"> 扩展字段2</label>
        </div>

        <div class="bizfield">
            <label> 是否支持协议代扣：</label><select id="isDirectPay" name="isDirectPay" value=""
                                             placeholder="0"
                                             required aria-required="true">
            <option value="0">0-否</option>
            <option value="1">1-是</option>
        </select>
            <label class="remark">必填，支持协议代扣，则“商户客户会员ID”与“签约协议号”必传</label>
        </div>
        <div class="bizfield">
            <label> 商户客户会员ID：</label><input type="text" name="merClientId"
                                            value="">
            <label class="remark"> 商户客户会员ID，选择支持协议代扣时，该字段必传</label>
        </div>
        <div class="bizfield">
            <label> 签约协议号：</label><input type="text" name="signDealNumber"
                                         value="">
            <label class="remark"> 签约协议号，选择支持协议代扣时，该字段必传</label>
        </div>
        <div class="bizfield">
            <label> 国检编号：</label><select id="aqsiqId" name="aqsiqId" value="">

            <option value="">空</option>
            <option value="0">0-不报国检</option>
            <option value="1">1-南沙国检</option>
        </select>
            <label class="remark"> 非必填</label>
        </div>
        <div class="bizfield">
            <label> 报送海关：</label><select id="cuId" name="cuId">
            <option value="">空</option>
            <option value="0">0-不报关</option>
            <option value="1">1-广州海关</option>
            <option value="2">2-上海海关</option>
            <option value="3">3-宁波海关</option>
            <option value="4">4-北京海关</option>
            <option value="5">5-杭州海关</option>
            <option value="6">6-重庆海关</option>
        </select>
            <label class="remark">非必填</label>
        </div>
        <div class="bizfield">
            <label> 业务类型：</label><select id="bizTypeCode" name="bizTypeCode" value=""
                                         placeholder="0">
            <option value="">空</option>
            <option value="I10">I10-直购进口</option>
            <option value="I20">I20-网购保税进口</option>
            <option value="E10">E10-一般出口B2C</option>
            <option value="E20">E20-一般出口B2B</option>
            <option value="E30">E30-保税出口B2C</option>
            <option value="E40">E40-保税出口B2B</option>
            <option value="E50">E50-虚拟商品出口</option>
        </select>
            <label class="remark">若报送海关选择了重庆关，则必填</label>
        </div>
        <div class="bizfield">
            <label> 商品货款金额：</label><input type="text" name="goodsFee" value="0.00"
                                          placeholder="0" pattern="^(([1-9]\d{0,9})|0)(\.\d{1,2})">
            <label class="remark">若报送海关选择了重庆关，则必填</label>
        </div>
        <div class="bizfield">
            <label> 税款金额：</label><input type="text" name="taxFee" value="0.00"
                                        placeholder="0" pattern="^(([1-9]\d{0,9})|0)(\.\d{1,2})">
            <label class="remark">若报送海关选择了重庆关，则必填</label>
        </div>

        <div class="bizfield">
            <label> 购汇种类：</label><select id="buyForexKind" name="buyForexKind" value=""
                                         placeholder="0">
            <option value="">空</option>
            <option value="0100">0100 货物贸易</option>
            <option value="0210">0210 运输</option>
            <option value="0221">0221 自费出境学习</option>
            <option value="0222">0222 因私旅游</option>
            <option value="0223">0223 公务及商务出国</option>
            <option value="0225">0225 旅游项下其他</option>
            <option value="0230">0230 金融和保险服务</option>
            <option value="0240">0240 专有权利使用费和特许费</option>
            <option value="0250">0250 咨询服务</option>
            <option value="0260">0260 其他服务</option>
        </select>
            <label class="remark">非必填</label>
        </div>
        <div class="bizfield">
            <input class="submit" type="submit" value="确认支付">
        </div>
    </form>
</div>
</html>
