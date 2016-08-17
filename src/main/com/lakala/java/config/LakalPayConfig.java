package com.lakala.java.config;

import java.util.concurrent.CopyOnWriteArrayList;

/**
 * desc:拉卡拉跨境支付配置类
 *
 * @author jiangzhifei jiangzhifei@lakala.com
 *         Created by jiang on 16/8/11.
 */
public class LakalPayConfig {
    /**
     * 商户号
     */
    public static final String MERCHANT_NO = "DOPCHN000025";

    /**
     * 商户私钥
     */
    public static final String PRIVATE_KEY = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALr+PCT5Q1oBUTdGnR8ZmaKcZG2JhlkolcI6mR02Ys/qRYd/m7CUsv9DT7fpNaW8xUyzsEvPS+uvnAV6Kfe7vMPKKbBQJwckklK4G7HpZHfIsaHvZBgdC5nLcgeRcijRSRUmJJWmy9B3HcGkCg/HTaXYiVQ2xEfqjfvNjkqsELFNAgMBAAECgYAWVFm2SJXEX7flE+ebWSFBi89qTSvf5brMcNbr6Bywm1cmMRTUZ01gshcI7S5c1kfxOtvokZ6NTHEjLk1oqeCGhI8BcVBxtZUkjR5N4J3b+7zxqh9upAjhdOappc2F4QZVxMKXTjpEHPGmP8pD0026hFR+UV2Ks9mwIuLHbGZIQQJBAN/h2L9qdnpyAFXa0jabWo4JNZp7p2IXn+uaUaM0OECqrywXa5f1A8bU3t9wkiOWW5eRFd5J2PZCjLeEEIoyvqUCQQDV0Z9sCbsOyMgSNpHhYBc5MDIBQvXy58I043gGeb8nFaNwQkkbag4z7Gd2y3yKm6/8C9lnEnlgXFBAy+8vOQ+JAkEAiGp4BKKdUJy4QZgU8LsWoWdRJzFjW2zjv86HIffGsviNxkL7B1t/Ep9QsjtIgLC0XJVGCu1aays/zO6GmX60FQJAOuiuC44Cw2f990ahmn5m55KntEFGkc3Ya8nf36jbSWFkziD1E2B82UFgoBIgFfAe5Eo/c25bknjcg32sQE5wQQJAD7p8/RsU6Gpr4yOMK3fc2H8AH4/u/N4Al0FHHVbLbU+ehl7PxKLMbg1/Db4XCCTdNhZ5tvaVJJkSfJ0nhrjAoA==";

    /**
     * 商户公钥
     */
    public static final String PUB_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPg0O4rPQJL1O+jqJ4rBjFVNRAuDmBSoii9pYfPQBaescCVY0irkWWoLyfTT65TjvnPpOx+IfNzBTlB13qCEFm7algREoeUHjFgFNHiXJ2LK/R0+VWgXe5+EDFfbrFCPnmLKG3OcKDGQszP0VOf6VVTM1t56CpgaRMm1/+Tzd2TQIDAQAB";

    /**
     * 拉卡拉服务器
     * 联调：http://testintl.lakala.com
     * 生产：https://intl.lakala.com
     */
    public static final String LKL_HOST = "http://testintl.lakala.com";

    /**
     * 端口
     * 联调:8080
     * 生产:7777
     */
    public static final String PORT = "8080";

}
