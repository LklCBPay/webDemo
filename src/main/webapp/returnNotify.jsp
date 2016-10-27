<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.lakala.java.util.LklMessageUtil" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.lakala.java.config.LakalPayConfig" %>
<%--
  接受拉卡拉异步回调
  author: jiangzhifei
  email:jiangzhifei@lakala.com
  Date: 16/8/22
  Time: 15:54
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>拉卡拉支付结果异步回调</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
</head>
<body>
<%
    PrintWriter writer = null;
    writer = response.getWriter();
    String submitMehtod = request.getMethod();
    String reqJson = "";
    Gson json = new Gson();
    Map<String, String> retMap = new HashMap<String, String>();
    try {
        if (submitMehtod.equals("GET")) {// GET
            reqJson = request.getQueryString();
        } else {// POST
            reqJson = LklMessageUtil.getRequestPostBytes(request);
        }
        if (null == reqJson || "".equals(reqJson)) {
            retMap.put("retCode", "0002");
            retMap.put("retMsg", "请求参数错误");
            writer.append(json.toJson(retMap, Map.class));
            writer.flush();
        }

        reqJson = URLDecoder.decode(reqJson, "utf-8");
        Map<String, String> jsonMap = json.fromJson(reqJson, Map.class);

        //商户私钥
        String privKey = LakalPayConfig.getPrivateKey();
        //公钥
        String pubKey = LakalPayConfig.getPubKey();

        // 2. 获取商户私钥，平台公钥，验证签名，解密
        if (jsonMap == null || !jsonMap.containsKey("reqType") || !jsonMap.containsKey("merId")
                || !jsonMap.containsKey("ts") || !jsonMap.containsKey("ver")
                || !jsonMap.containsKey("encKey") || !jsonMap.containsKey("encData")
                || !jsonMap.containsKey("mac")) {
            // 参数上送错误
            retMap.put("retCode", "0002");
            retMap.put("retMsg", "请求参数错误");
            ;
            writer.append(json.toJson(retMap, Map.class));
            writer.flush();
        }
        String merId = (String) jsonMap.get("merId");
        if (null == merId || "".equals(merId)) {
            retMap.put("retCode", "0002");
            retMap.put("retMsg", "请求参数错误");
            writer.append(json.toJson(retMap, Map.class));
            writer.flush();
        }

        // 解密、验证mac
        retMap = LklMessageUtil.decryptReqDataforNotify(jsonMap, pubKey, privKey);
        if (!"0000".equals(retMap.get("retCode"))) {
            writer.append(json.toJson(retMap, Map.class));
            writer.flush();
            return;
        }
        //获取解析后的参数
        String reqData = retMap.get("reqData");
        //获取解密后的业务参数
        Map<String, String> params = json.fromJson(reqData, Map.class);
        /**
         * 此处可以实现自己的业务逻辑
         */

        //构造响应参数
        Map<String, String> map = new HashMap<String, String>();
        map.put("merOrderId", params.get("merOrderId"));
        map.put("transactionId", params.get("transactionId"));

        String resData = json.toJson(map, Map.class);
        String merKey = retMap.get("merKey");

        // 5. 签名，加密响应结果给拉卡拉
        Map<String, String> resMap = LklMessageUtil.encryRetData(resData, jsonMap, merKey, privKey);
        // 6. 返回响应
        writer.append(json.toJson(resMap, Map.class));
        writer.flush();
    } catch (Exception e) {
        retMap.put("retCode", "9999");
        retMap.put("retMsg", "系统异常");
        writer.append(json.toJson(retMap, Map.class));
        writer.flush();
    }

%>
</body>
</html>
