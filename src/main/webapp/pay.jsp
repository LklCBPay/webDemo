<%@ page import="com.lakala.java.util.LklMessageUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
</head>
<body>
<%
    String ver = new String(request.getParameter("ver").getBytes("ISO-8859-1"), "UTF-8");
    String reqType = new String(request.getParameter("reqType").getBytes("ISO-8859-1"), "UTF-8");
    String merId = new String(request.getParameter("merId").getBytes("ISO-8859-1"), "UTF-8");
    String payTypeId = new String(request.getParameter("payTypeId").getBytes("ISO-8859-1"), "UTF-8");
    String bizCode = new String(request.getParameter("bizCode").getBytes("ISO-8859-1"), "UTF-8");
    String ts = new String(request.getParameter("ts").getBytes("ISO-8859-1"), "UTF-8");
    String merOrderId = new String(request.getParameter("merOrderId").getBytes("ISO-8859-1"), "UTF-8");
    String currency = new String(request.getParameter("currency").getBytes("ISO-8859-1"), "UTF-8");
    String orderAmount = new String(request.getParameter("orderAmount").getBytes("ISO-8859-1"), "UTF-8");
    String orderSummary = new String(request.getParameter("orderSummary").getBytes("ISO-8859-1"), "UTF-8");
    String orderTime = new String(request.getParameter("orderTime").getBytes("ISO-8859-1"), "UTF-8");
    String orderEffTime = new String(request.getParameter("orderEffTime").getBytes("ISO-8859-1"), "UTF-8");
    String timeZone = new String(request.getParameter("timeZone").getBytes("ISO-8859-1"), "UTF-8");
    String pageUrl = new String(request.getParameter("pageUrl").getBytes("ISO-8859-1"), "UTF-8");
    String bgUrl = new String(request.getParameter("bgUrl").getBytes("ISO-8859-1"), "UTF-8");
    String ext1 = new String(request.getParameter("ext1").getBytes("ISO-8859-1"), "UTF-8");
    String ext2 = new String(request.getParameter("ext2").getBytes("ISO-8859-1"), "UTF-8");
    String isDirectPay = new String(request.getParameter("isDirectPay").getBytes("ISO-8859-1"), "UTF-8");
    String merClientId = new String(request.getParameter("merClientId").getBytes("ISO-8859-1"), "UTF-8");
    String signDealNumber = new String(request.getParameter("signDealNumber").getBytes("ISO-8859-1"), "UTF-8");
    String aqsiqId = new String(request.getParameter("aqsiqId").getBytes("ISO-8859-1"), "UTF-8");

    String payeeAmount = request.getParameter("payeeAmount");
    String cuId = request.getParameter("cuId");
    String bizTypeCode = request.getParameter("bizTypeCode");
    String goodsFee = request.getParameter("goodsFee");
    String taxFee = request.getParameter("taxFee");
    String buyForexKind = request.getParameter("buyForexKind");
    String customNumberId = request.getParameter("customNumberId");


    Map<String, String> paraMap = new HashMap<String, String>();
    paraMap.put("ver", ver);
    paraMap.put("reqType", reqType);
    paraMap.put("merId", merId);
    paraMap.put("payTypeId", payTypeId);
    if (null != bizCode && !"".equals(bizCode)) {
        paraMap.put("bizCode", bizCode);
    }
    paraMap.put("ts", ts);
    paraMap.put("merOrderId", merOrderId);
    paraMap.put("currency", currency);
    paraMap.put("orderAmount", orderAmount);
    if (null != orderSummary && !"".equals(orderSummary)) {
        paraMap.put("orderSummary", orderSummary);
    }
    paraMap.put("orderTime", orderTime);
    paraMap.put("orderEffTime", orderEffTime);
    paraMap.put("timeZone", timeZone);
    if (null != pageUrl && !"".equals(pageUrl)) {
        paraMap.put("pageUrl", pageUrl);
    }
    if (null != bgUrl && !"".equals(bgUrl)) {
        paraMap.put("bgUrl", bgUrl);
    }
    if (null != ext1 && !"".equals(ext1)) {
        paraMap.put("ext1", ext1);
    }
    if (null != ext2 && !"".equals(ext2)) {
        paraMap.put("ext2", ext2);
    }
    paraMap.put("isDirectPay", isDirectPay);
    if (null != merClientId && !"".equals(merClientId)) {
        paraMap.put("merClientId", merClientId);
    }
    if (null != signDealNumber && !"".equals(signDealNumber)) {
        paraMap.put("signDealNumber", signDealNumber);
    }
    if (null != aqsiqId && !"".equals(aqsiqId)) {
        paraMap.put("aqsiqId", aqsiqId);
    }
    if (null != payeeAmount && !"".equals(payeeAmount)) {
        payeeAmount = new String(payeeAmount.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("payeeAmount", payeeAmount);
    }

    if (null != cuId && !"".equals(cuId)) {
        cuId = new String(cuId.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("cuId", cuId);
    }

    if (null != bizTypeCode && !"".equals(bizTypeCode)) {
        bizTypeCode = new String(bizTypeCode.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("bizTypeCode", bizTypeCode);
    }

    if (null != goodsFee && !"".equals(goodsFee)) {
        goodsFee = new String(goodsFee.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("goodsFee", goodsFee);
    }

    if (null != taxFee && !"".equals(taxFee)) {
        taxFee = new String(taxFee.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("taxFee", taxFee);
    }

    if (null != buyForexKind && !"".equals(buyForexKind)) {
        buyForexKind = new String(buyForexKind.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("buyForexKind", buyForexKind);
    }
    if (null != customNumberId && !"".equals(customNumberId)) {
        customNumberId = new String(customNumberId.getBytes("ISO-8859-1"), "utf-8");
        paraMap.put("customNumberId", customNumberId);
    }

    out.println(LklMessageUtil.submit(paraMap, request.getParameter("requestUri")));

%>
</body>
</html>
