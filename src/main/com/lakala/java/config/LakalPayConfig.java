package com.lakala.java.config;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * desc:拉卡拉跨境支付配置类
 *
 * @author jiangzhifei jiangzhifei@lakala.com
 *         Created by jiang on 16/8/11.
 */
public class LakalPayConfig {

    private static final Map<String, String> ENV_CONFIG = new ConcurrentHashMap<String, String>();

    private static ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    /**
     * 商户号
     */
    private static final String MERCHANT_NO = "DOPCHN000025";

    /**
     * 商户私钥
     */
    private static final String PRIVATE_KEY = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALr+PCT5Q1oBUTdGnR8ZmaKcZG2JhlkolcI6mR02Ys/qRYd/m7CUsv9DT7fpNaW8xUyzsEvPS+uvnAV6Kfe7vMPKKbBQJwckklK4G7HpZHfIsaHvZBgdC5nLcgeRcijRSRUmJJWmy9B3HcGkCg/HTaXYiVQ2xEfqjfvNjkqsELFNAgMBAAECgYAWVFm2SJXEX7flE+ebWSFBi89qTSvf5brMcNbr6Bywm1cmMRTUZ01gshcI7S5c1kfxOtvokZ6NTHEjLk1oqeCGhI8BcVBxtZUkjR5N4J3b+7zxqh9upAjhdOappc2F4QZVxMKXTjpEHPGmP8pD0026hFR+UV2Ks9mwIuLHbGZIQQJBAN/h2L9qdnpyAFXa0jabWo4JNZp7p2IXn+uaUaM0OECqrywXa5f1A8bU3t9wkiOWW5eRFd5J2PZCjLeEEIoyvqUCQQDV0Z9sCbsOyMgSNpHhYBc5MDIBQvXy58I043gGeb8nFaNwQkkbag4z7Gd2y3yKm6/8C9lnEnlgXFBAy+8vOQ+JAkEAiGp4BKKdUJy4QZgU8LsWoWdRJzFjW2zjv86HIffGsviNxkL7B1t/Ep9QsjtIgLC0XJVGCu1aays/zO6GmX60FQJAOuiuC44Cw2f990ahmn5m55KntEFGkc3Ya8nf36jbSWFkziD1E2B82UFgoBIgFfAe5Eo/c25bknjcg32sQE5wQQJAD7p8/RsU6Gpr4yOMK3fc2H8AH4/u/N4Al0FHHVbLbU+ehl7PxKLMbg1/Db4XCCTdNhZ5tvaVJJkSfJ0nhrjAoA==";

    /**
     * 商户公钥
     */
    private static final String PUB_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPg0O4rPQJL1O+jqJ4rBjFVNRAuDmBSoii9pYfPQBaescCVY0irkWWoLyfTT65TjvnPpOx+IfNzBTlB13qCEFm7algREoeUHjFgFNHiXJ2LK/R0+VWgXe5+EDFfbrFCPnmLKG3OcKDGQszP0VOf6VVTM1t56CpgaRMm1/+Tzd2TQIDAQAB";

    /**
     * 拉卡拉服务器
     * 联调：http://testintl.lakala.com
     * 生产：https://intl.lakala.com
     */
    public static String LKL_HOST = "http://testintl.lakala.com";

    /**
     * 端口
     * 联调:8080
     * 生产:7777
     */
    public static String PORT = "8080";

    static {
        ENV_CONFIG.put("merchantNo", MERCHANT_NO);
        ENV_CONFIG.put("privateKey", PRIVATE_KEY);
        ENV_CONFIG.put("pubKey", PUB_KEY);
    }

    public static void setMerchantNo(String merchantNo) {

        ENV_CONFIG.put("merchantNo", merchantNo);

    }

    /**
     * 获取商户号，若无则取默认
     *
     * @return
     */
    public static String getMerchantNo() {
        String merchantNo = ENV_CONFIG.get("merchantNo");
        if (null == merchantNo || "".equals(merchantNo)) {
            merchantNo = MERCHANT_NO;
        }
        return merchantNo;
    }

    public static void setPrivateKey(String privateKey) {
        ENV_CONFIG.put("privateKey", privateKey);

    }

    public static String getPrivateKey() {
        String privateKey = ENV_CONFIG.get("privateKey");
        if (null == privateKey || "".equals(privateKey)) {
            privateKey = PRIVATE_KEY;
        }
        return privateKey;
    }

    public static void setPubKey(String pubKey) {
        ENV_CONFIG.put("pubKey", pubKey);

    }

    public static String getPubKey() {
        String pubKey = ENV_CONFIG.get("pubKey");
        if (null == pubKey || "".equals(pubKey)) {
            pubKey = PUB_KEY;
        }
        return pubKey;
    }

    /**
     * 切换到生产环境，默认是sandbox
     */
    public static void getLiveEnv() {
        try {
            lock.writeLock().lock();
            LKL_HOST = "https://intl.lakala.com";
            PORT = "7777";
        } finally {
            lock.writeLock().unlock();
        }
    }

    /**
     * 切换到sandbox，默认是生产环境
     */
    public static void getSandBoxEnv() {
        try {
            lock.writeLock().lock();
            LKL_HOST = "http://testintl.lakala.com";
            PORT = "8080";
        } finally {
            lock.writeLock().unlock();
        }
    }

    /**
     * 恢复默认环境设置，即读入LakalPayConfig类中的初始值
     */
    public static void setDefaultEnv() {
        try {
            lock.writeLock().lock();
            LKL_HOST = "http://testintl.lakala.com";
            PORT = "8080";
            ENV_CONFIG.put("merchantNo", MERCHANT_NO);
            ENV_CONFIG.put("privateKey", PRIVATE_KEY);
            ENV_CONFIG.put("pubKey", PUB_KEY);
        } finally {
            lock.writeLock().unlock();
        }
    }
}
