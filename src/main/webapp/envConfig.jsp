<%@ page import="com.lakala.java.util.LklMessageUtil" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.lakala.java.config.LakalPayConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
</head>
<body>
<%
    String env = request.getParameter("env");
    String merId = request.getParameter("merId");
    String prvKey = request.getParameter("prvKey");
    String pubKey = request.getParameter("pubKey");


    if ("2".equals(env)) {
        LakalPayConfig.setDefaultEnv();

    } else {
        if ("0".equals(env)) {
            LakalPayConfig.getSandBoxEnv();
        } else if ("1".equals(env)) {
            LakalPayConfig.getLiveEnv();
        }
        if (null != merId && !"".equals(merId)) {
            LakalPayConfig.setMerchantNo(merId);
        }

        if (null != prvKey && !"".equals(prvKey)) {
            LakalPayConfig.setPrivateKey(prvKey);
        }

        if (null != pubKey && !"".equals(pubKey)) {
            LakalPayConfig.setPubKey(pubKey);
        }
    }

    out.print("host=" + LakalPayConfig.LKL_HOST + "<br>");
    out.print("PORT=" + LakalPayConfig.PORT + "<br>");
    out.print("merid=" + LakalPayConfig.getMerchantNo() + "<br>");
    out.print("privateKey=" + LakalPayConfig.getPrivateKey() + "<br>");
    out.print("pubKey=" + LakalPayConfig.getPubKey() + "<br>");
%>
</body>
</html>
