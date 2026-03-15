package com.ideaflow.noveldownload.novel.util;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.ideaflow.noveldownload.novel.model.AppConfig;
import lombok.SneakyThrows;
import lombok.experimental.UtilityClass;
import okhttp3.*;
import okio.Buffer;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.http.HttpStatusCode;
import org.springframework.web.client.HttpClientErrorException;


/**
 * 爬虫工具类
 * <p>
 * 提供构建 POST 请求体、随机间隔时间、清理不可见字符等功能。
 */
@UtilityClass
public class CrawlUtils {

    // 构建 POST Body
    public static RequestBody buildData(String jsonStr, String... args) {
        FormBody.Builder form = new FormBody.Builder();
        AtomicInteger i = new AtomicInteger(0);

        JSONUtil.parseObj(jsonStr)
                .forEach((key, value) -> {
                    if ("%s".equals(value)) {
                        if (i.get() < args.length) {
                            form.add(key, args[i.getAndIncrement()]);
                        }
                    } else {
                        form.add(key, value.toString());
                    }
                });

        return form.build();
    }

    public long randomInterval(AppConfig config) {
        return randomInterval(config, false);
    }

    public long randomInterval(AppConfig config, boolean isRetry) {
        return ThreadLocalRandom.current().nextLong(
                isRetry ? config.getRetryMinInterval() : config.getMinInterval(),
                isRetry ? config.getRetryMaxInterval() : config.getMaxInterval());
    }

    public String cleanInvisibleChars(String text) {
        // 过滤：控制字符、格式控制符、私有区 PUA 字符 (导致中文乱码的根源)
        return StrUtil.isEmpty(text) ? "" : text.replaceAll("[\\p{C}\\p{Cf}\\p{Co}\\p{Zl}\\p{Zp}\\u200B\\uFEFF]", "");
    }

    public String replaceIntroTags(String text) {
        return text.replaceAll("</(?:p|div)>|<p */>|<br[^>]*?>", "\n")
                    .replaceAll("<[^>]*?>", "")
                    .replaceAll("&amp;", "&")
                    .replaceAll("&lt;", "<")
                    .replaceAll("&gt;", ">")
                    .replaceAll("&[^;]+;", "")
                    .replaceAll("[\\r\\n]+", "\n");
    }

    // @SneakyThrows
    // public Response request(OkHttpClient client, String url, int timeout) {
    //     Call call = client.newCall(new Request.Builder()
    //             .url(url)
    //             .addHeader("User-Agent", RandomUA.generate())
    //             .build());
    //     call.timeout().timeout(timeout, TimeUnit.SECONDS);
    //     dumpRequestInfo(call.request());    // DEBUG

    //     return call.execute();
    // }

    // @SneakyThrows
    // public Response request(OkHttpClient client, Request.Builder builder, int timeout) {
    //     Call call = client.newCall(builder
    //             .addHeader("User-Agent", RandomUA.generate())
    //             .build()
    //     );
    //     call.timeout().timeout(timeout, TimeUnit.SECONDS);
    //     dumpRequestInfo(call.request());    // DEBUG

    //     return call.execute();
    // }

    @SneakyThrows
    public String requestHtml(OkHttpClient client, Request.Builder builder, int timeout) {
        Call call = client.newCall(builder
                .addHeader("User-Agent", RandomUA.generate())
                .build()
        );
        call.timeout().timeout(timeout, TimeUnit.SECONDS);
        dumpRequestInfo(call.request());    // DEBUG

        String html = "";
        try (Response resp = call.execute()) {
            byte[] htmlBytes = resp.body().bytes();
            if (resp.isSuccessful()) {
                // Get text encoding from header
                if (resp.body().contentType() != null) {
                    Charset charset = resp.body().contentType().charset();
                    cn.hutool.core.lang.Console.log("[D]Response charset from header: {}", charset);
                    if (charset != null) {
                        html = new String(htmlBytes, charset);
                    }
                }

                // Get text encoding from html
                if (html.length() == 0) {
                    String tmpHtml = new String(htmlBytes, StandardCharsets.UTF_8);
                    Pattern extractCharset = Pattern.compile("<meta charset=\"([^\"]+)\">");
                    Matcher matcher = extractCharset.matcher(tmpHtml);
                    if (matcher.find()) {
                        cn.hutool.core.lang.Console.log("[D]Response charset from body: {}", matcher.group(1));
                        html = new String(htmlBytes, matcher.group(1));
                    }
                }

                // Default
                if (html.length() == 0) {
                    html = new String(htmlBytes, StandardCharsets.UTF_8);
                }
            } else {
                cn.hutool.core.lang.Console.log("[E]Code: {}, Html: {}", resp.code(), new String(htmlBytes, StandardCharsets.UTF_8));
                throw new HttpClientErrorException(HttpStatusCode.valueOf(resp.code()), resp.message());
            }
        }

        return html;
    }

    @SneakyThrows
    public String requestHtml(OkHttpClient client, String url, int timeout) {
        return requestHtml(client, new Request.Builder().url(url), timeout);
    }

    private void dumpRequestInfo(Request request) {
        cn.hutool.core.lang.Console.log("[D]{} {}", request.method(), request.url().url().toString());
        cn.hutool.core.lang.Console.log("[D]Headers");
        request.headers().forEach(header -> {
            cn.hutool.core.lang.Console.log("  {}: {}", header.component1(), header.component2());
        });
        if (request.body() != null) {
            try {
                final Buffer buf = new Buffer();
                request.body().writeTo(buf);
                cn.hutool.core.lang.Console.log("[D]Data: [{}]{}", request.body().contentLength(), buf.readUtf8());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}