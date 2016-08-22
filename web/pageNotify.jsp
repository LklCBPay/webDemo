<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.lakala.java.config.LakalPayConfig" %>
<%@ page import="com.lakala.java.util.LklMessageUtil" %>
<%@ page import="com.google.gson.Gson" %>
<%--
 desc:页面回调。接受拉卡拉支付结果同步回调
 @author jiangzhifei jiangzhifei@lakala.com
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>拉卡拉跨境支付结果</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
</head>
<body>
<table style="border: 0px">
    <%
        Map<String, String> jsonMap = new HashMap<String, String>();
        Enumeration enumeration = request.getParameterNames();
        String name;
        while (enumeration.hasMoreElements()) {
            name = (String) enumeration.nextElement();
            jsonMap.put(name, request.getParameter(name));
        }

        String responseCode = jsonMap.get("retCode");
        String responseMsg = jsonMap.get("retMsg");

        if (!"0000".equals(responseCode)) {
    %>
    <tr>
        <td>支付失败：</td>
        <td><%=responseMsg%>
        </td>
    </tr>
    <%
        }
    %>
    <%
        String merId = (String) jsonMap.get("merId");
        //商户私钥
        String privKey = LakalPayConfig.getPrivateKey();
        //公钥
        String pubKey = LakalPayConfig.getPubKey();
        Map<String, String> resMap = new HashMap<String, String>();

        if (jsonMap.get("encData") != null) {
            resMap = LklMessageUtil.decryptReqData(jsonMap, pubKey, privKey);

            String reqData = resMap.get("reqData");
            Map<String, String> json = new Gson().fromJson(reqData, Map.class);
            String payResult = json.get("payResult");
            String payResultMsg = null;
            if ("1".equals(payResult)) {
                payResultMsg = "支付成功";
            } else if ("2".equals(payResult)) {
                payResultMsg = "支付失败";
            } else if ("0".equals(payResult)) {
                payResultMsg = "未支付";
            }

            out.print(" <tr>\n" +
                    "        <td>支付结果：</td>\n" +
                    "        <td>" + new String(responseMsg.getBytes("ISO-8859-1"), "utf-8") + "\n" +
                    "        </td>\n" +
                    "    </tr>");

            out.print(" <tr>\n" +
                    "        <td>retCode：</td>\n" +
                    "        <td>" + new String(responseCode.getBytes("ISO-8859-1"), "utf-8") + "\n" +
                    "        </td>\n" +
                    "    </tr>");

            out.print(" <tr>\n" +
                    "        <td>retMsg：</td>\n" +
                    "        <td>" + new String(responseMsg.getBytes("ISO-8859-1"), "utf-8") + "\n" +
                    "        </td>\n" +
                    "    </tr>");
        }
        for (Map.Entry<String, String> entry : jsonMap.entrySet()) {
            out.print(" <tr>\n" +
                    "        <td>" + new String(entry.getKey().getBytes("ISO-8859-1"), "utf-8") + "</td>\n" +
                    "        <td>" + new String(entry.getValue().getBytes("ISO-8859-1"), "utf-8") + "\n" +
                    "        </td>\n" +
                    "    </tr>");
        }

    %>

</table>
</body>
</html>
