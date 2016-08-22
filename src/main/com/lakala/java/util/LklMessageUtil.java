package com.lakala.java.util;

import com.google.gson.Gson;
import com.lakala.java.config.LakalPayConfig;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * 描述：拼装业务参数并提交到拉卡拉服务器
 *
 * @author jiangzhifei jiangzhifei@lakala.com
 *         Created by jiang on 16/8/11.
 */
public class LklMessageUtil {


    /**
     * 根据给定参数提交
     *
     * @param param
     * @return
     */
    public static String submit(Map<String, String> param, String url) throws Exception {
        //1.获取该笔订单的对称密钥,32位
        String desKey = ToolsUtil.getDesKey(32);
        //公钥
        String pubKey = LakalPayConfig.getPubKey();
        //私钥
        String privKey = LakalPayConfig.getPrivateKey();
        //商户号
        String merNo = LakalPayConfig.getMerchantNo();
        //时间戳
        String timeStamp = param.get("ts");

        String payTypeId = param.get("payTypeId");

        String reqType = param.get("reqType");


        String encKeyStr = timeStamp + desKey;
        //生成enckey
        String encKey = ByteArrayUtil.byteArray2HexString(RSAUtil.encryptByPublicKey(encKeyStr.getBytes("GBK"), pubKey));

        Gson json = new Gson();
        String bizJson = json.toJson(param, Map.class);

        //生成encData
        String encData = ByteArrayUtil.byteArray2HexString(DESCrypto.enCrypto(bizJson.getBytes("GBK"), desKey));
        String ver = param.get("ver");
        //拼接mac原文字符串
        String macStr = null;
        if ("1.0.0".equals(ver.trim())) {
            if (null == payTypeId || "".equals(payTypeId)) {
                macStr = merNo + ver + timeStamp + reqType + encData + "";
            } else {
                macStr = merNo + ver + timeStamp + reqType + encData + payTypeId;
            }
        } else if ("2.0.0".equals(ver.trim())) {
            macStr = merNo + ver + timeStamp + encData;
        }
        //SHA-1
        //first encrypt mac with sha-1
        //得到mac签名
        macStr = DigestUtil.Encrypt(macStr, "SHA-1");
        String mac = ByteArrayUtil.byteArray2HexString(RSAUtil.encryptByPrivateKey(macStr.getBytes("GBK"), privKey));
        ToolsUtil.storeMerKey(LakalPayConfig.getMerchantNo(), desKey);
        param.clear();
        param.put("merId", merNo);
        param.put("payTypeId", payTypeId);
        param.put("ver", ver);
        param.put("ts", timeStamp);
        param.put("encData", encData);
        param.put("encKey", encKey);
        param.put("mac", mac);
        param.put("reqType", reqType);

        StringBuffer sbf = new StringBuffer();
        sbf.append("<form name=\"jumpForm\" method=\"post\" style=\"display: none;\" action=")
                .append(LakalPayConfig.LKL_HOST + ":" + LakalPayConfig.PORT + "/" + url).append(">");
        for (Map.Entry<String, String> entry : param.entrySet()) {
            sbf.append("<input type='hidden' name='").append(entry.getKey()).append("' value=\"").append(entry.getValue()).append("\" />");
        }
        sbf.append("</form>\n" +
                "<script type=\"text/javascript\">\n" +
                "    document.jumpForm.submit();\n" +
                "</script>");
        return sbf.toString();

    }

    /**
     * 解密拉卡拉响应消息
     *
     * @param params        拉卡拉响应消息
     * @param platPublicKey 公钥
     * @param merPrivateKey 私钥
     * @return
     */
    public static Map<String, String> decryptReqData(Map<String, String> params,
                                                     String platPublicKey, String merPrivateKey) throws UnsupportedEncodingException {
        // 响应码
        String retCode = (String) params.get("retCode");
        String retMsg = (String) params.get("retMsg");
        if (null != retMsg) {
            retMsg = new String(retMsg.getBytes("ISO-8859-1"), "utf-8");
        }
        String ts = (String) params.get("ts");
        String reqType = (String) params.get("reqType");
        String reqEncData = (String) params.get("encData");
        String reqMac = (String) params.get("mac");
        String merId = (String) params.get("merId");
        String ver = (String) params.get("ver");
        String payTypeId = (String) params.get("payTypeId");
        //取得商户对称密钥，同商户发起交易时的密钥
        String desKey = ToolsUtil.getMerKey(LakalPayConfig.getMerchantNo());

        // 用请求方公钥验签（拼接时间戳、业务类型、“加密json1”做SHA1，用请求方公钥解密mac反hex的字节数组，比较是否一致）
        String macData = null;
        if (null == payTypeId || "".equals(payTypeId)) {
            macData = DigestUtil.Encrypt(retCode + retMsg + merId + ver + ts + reqType + reqEncData, "SHA-1");
        } else {
            macData = DigestUtil.Encrypt(retCode + retMsg + merId + ver + ts + reqType + reqEncData + payTypeId, "SHA-1");
        }

        String reqMacStr = "";
        try {
            reqMacStr = new String(RSAUtil.decryptByPublicKey(
                    ByteArrayUtil.hexString2ByteArray(reqMac), platPublicKey));
        } catch (Exception e) {
            e.printStackTrace();
            params.put("retCode", "0016");
            params.put("retMsg", "解密mac失败");
            return params;
        }
        // mac校验
        if (!macData.equals(reqMacStr)) {
            params.put("retCode", "0015");
            params.put("retMsg", "mac校验失败");
            return params;
        }

        if (desKey == null) return params;

        // 对称密钥解密“加密json1”，得到明文“请求业务json”
        String reqData = "";
        try {
            reqData = new String(DESCrypto.deCrypt(
                    ByteArrayUtil.hexString2ByteArray(reqEncData), desKey), "GBK");
        } catch (Exception e) {
            e.printStackTrace();
            params.put("retCode", "0011");
            params.put("retMsg", "解密业务参数失败");
            return params;
        }
//        params.put("retCode", "0000");
        params.put("reqData", reqData);
        params.put("merKey", desKey);
        return params;
    }

    /**
     * 解密拉卡拉异步响应数据  异步通知
     *
     * @param params
     * @param platPublicKey
     * @param merPrivateKey
     * @return
     */
    public static Map<String, String> decryptReqDataforNotify(Map<String, String> params,
                                                              String platPublicKey, String merPrivateKey) {
        String ts = (String) params.get("ts");
        String reqType = (String) params.get("reqType");
        String reqEncKey = (String) params.get("encKey");
        String reqEncData = (String) params.get("encData");
        String reqMac = (String) params.get("mac");

        params.remove("mac");
        params.remove("encData");
        params.remove("encKey");

        // 用请求方公钥验签（拼接时间戳、业务类型、“加密json1”做SHA1，用请求方公钥解密mac反hex的字节数组，比较是否一致）
        String reqmacStr = DigestUtil.Encrypt(ts + reqType + reqEncData, "SHA-1");
        String reqMacStr = "";
        try {
            reqMacStr = new String(RSAUtil.decryptByPublicKey(
                    ByteArrayUtil.hexString2ByteArray(reqMac), platPublicKey));
        } catch (Exception e) {
            params.put("retCode", "0016");
            params.put("retMsg", "解密mac失败");
            return params;
        }
        // mac校验
        if (!reqmacStr.equals(reqMacStr)) {
            params.put("retCode", "0015");
            params.put("retMsg", "mac校验失败");
            return params;
        }
        // 用私钥解密encKey密文，取后32个字符反HEX，得对称密钥
        String merKey = ""; // 商户对称密钥
        try {
            merKey = new String(RSAUtil.decryptByPrivateKey(
                    ByteArrayUtil.hexString2ByteArray(reqEncKey),
                    merPrivateKey));
        } catch (Exception e) {
            params.put("retCode", "0017");
            params.put("retMsg", "解密商户对称密钥失败");
            return params;
        }
        merKey = merKey.substring(merKey.length() - 32, merKey.length());
        // 对称密钥解密“加密json1”，得到明文“请求业务json”
        String reqData = "";
        try {
            reqData = new String(DESCrypto.deCrypt(
                    ByteArrayUtil.hexString2ByteArray(reqEncData), merKey), "GBK");
        } catch (Exception e) {
            params.put("retCode", "0011");
            params.put("retMsg", "解密业务参数失败");
            return params;
        }
        params.put("retCode", "0000");
        params.put("reqData", reqData);
        params.put("merKey", merKey);
        return params;
    }

    /**
     * 加密拉卡拉异步支付结果通知响应，返回给拉卡拉
     *
     * @param resJsonData
     * @param reqMap
     * @param merDesStr
     * @param merPrivateKey
     * @return
     */
    public static Map<String, String> encryRetData(String resJsonData, Map<String, String> reqMap, String merDesStr, String merPrivateKey) throws Exception {
        String retCode = "0000";
        String retMsg = "成功";

        String ts = reqMap.get("ts");
        String ver = reqMap.get("ver");
        String merId = reqMap.get("merId");
        String reqType = reqMap.get("reqType");
        Map<String, String> jsonMap = new HashMap<String, String>();
        jsonMap.put("merId", merId);
        jsonMap.put("ver", ver);
        jsonMap.put("ts", ts);
        jsonMap.put("reqType", reqType);
        if ((null == resJsonData || "".equals(resJsonData))
                || (null == ts || "".equals(ts))
                || (null == ver || "".equals(ver))
                || (null == reqType || "".equals(reqType))
                || (null == merDesStr || "".equals(merDesStr))
                ) {
            jsonMap.put("retCode", "0002");
            jsonMap.put("retMsg", "请求参数错误");
            return jsonMap;
        }

        Gson json = new Gson();
        Map resMap_tmp = json.fromJson(resJsonData, Map.class);
        if (resMap_tmp != null && resMap_tmp.containsKey("retCode")) {
            retCode = (String) resMap_tmp.get("retCode");
            retMsg = (String) (resMap_tmp.get("retMsg") == null ? null : resMap_tmp.get("retMsg"));
            if (null == retCode || "".equals(retCode)) {
                retCode = "0000";
                retMsg = "成功";
            }
        }
        resMap_tmp.remove("retCode");
        resMap_tmp.remove("retMsg");
        resJsonData = json.toJson(resMap_tmp, Map.class);

        // 1.使用请求方上送的对称密钥加密响应业务JSON，生成加密JSON2
        String encData = ByteArrayUtil.byteArray2HexString(DESCrypto.enCrypto(
                resJsonData.getBytes("GBK"), merDesStr));

        // 2.拼接时间戳、业务类型、加密JSON2 做SHA1，响应方私钥加密，HEX，得MAC
        String mac_tmp = DigestUtil.Encrypt(ts + reqType + encData, "SHA-1", "GBK");
        String mac = "";
        try {
            mac = ByteArrayUtil.byteArray2HexString(RSAUtil
                    .encryptByPrivateKey(mac_tmp.getBytes(), merPrivateKey));
        } catch (Exception e) {
            jsonMap.put("retCode", "0012");
            jsonMap.put("retMsg", "加密返回数据失败");
            return jsonMap;
        }

        jsonMap.put("encData", encData);
        jsonMap.put("mac", mac);
        jsonMap.put("retCode", retCode);
        jsonMap.put("retMsg", retMsg);
        return jsonMap;
    }

    public static String getRequestPostBytes(HttpServletRequest request)
            throws IOException {
        int contentLength = request.getContentLength();
        if (contentLength < 0) {
            return null;
        }
        byte buffer[] = new byte[contentLength];
        for (int i = 0; i < contentLength; ) {
            int readlen = request.getInputStream().read(buffer, i,
                    contentLength - i);
            if (readlen == -1) {
                break;
            }
            i += readlen;
        }

        return new String(buffer, "utf-8");
    }
}
