package com.lakala.java.util;

import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

/**
 * <p>
 * 工具类
 * </p>
 */
public class ToolsUtil {

    /**
     * <p>
     * 存储商户生成的对称密钥
     * </p>
     * key=为唯一标识，例如单号
     */
    private static final ConcurrentHashMap<String, String> LOCAL_MERKEY = new ConcurrentHashMap<String, String>();

    /**
     * 随机生成字符串(自定义长度)作为对称密钥
     *
     * @param length 自定义长度
     * @return
     */
    public static String getDesKey(int length) {
        String radStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuffer generateRandStr = new StringBuffer();
        Random rand = new Random();
        for (int i = 0; i < length; i++) {
            int randNum = rand.nextInt(36);
            generateRandStr.append(radStr.substring(randNum, randNum + 1));
        }
        return generateRandStr + "";
    }

    /**
     * @param key
     * @return
     */
    public static String getMerKey(String key) {
        return LOCAL_MERKEY.get(key);
    }

    /**
     * 设置对称密钥
     *
     * @param key
     */
    public static void storeMerKey(String key, String desKey) {
        LOCAL_MERKEY.put(key, desKey);
    }

    public static void remove(String key) {
        LOCAL_MERKEY.remove(key);
    }


}

