package com.ideaflow.noveldownload.novel.util;

import cn.hutool.core.util.StrUtil;
import com.ideaflow.noveldownload.novel.model.ContentType;
import lombok.experimental.UtilityClass;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import static com.ideaflow.noveldownload.novel.model.ContentType.*;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Jsoup 工具类
 * <p>
 * 提供对 Jsoup 元素的选择和 JS 脚本执行的封装。
 * 支持通过查询条件选择元素，并执行可能的 JS 脚本。
 */
@UtilityClass
public class JsoupUtils {

    public static final String SEPARATOR_PATTERN = "@[a-z]+?:";
    public static final String JS_SEPARATOR = "@js:";
    public static final String REGEXP_SEPARATOR = "@re:";
    public static final String ATTR_SEPARATOR = "@attr:";

    /**
     * 使用查询条件选择元素
     * <p>
     * 等价于 document.select(query) | document.selectXpath(query)
     */
    public Elements select(Element e, String query) {
        // 分割查询条件以提取 XPath 或 CSS 查询
        String actualQuery = query.split(SEPARATOR_PATTERN)[0];
        // 根据查询条件选择元素
        return actualQuery.matches("^(/|//|\\(/).*") ? e.selectXpath(actualQuery) : e.select(actualQuery);
    }

    /**
     * 执行 JS 脚本并返回处理结果
     * <p>
     * 等价于 func(input)
     */
    public String invokeJs(String query, String input) {
        if (StrUtil.isEmpty(query)) {
            return input;
        }

        // @js:
        String[] split = query.split(JS_SEPARATOR);
        if (split.length == 1) {
            return input;
        }

        return JsCaller.call(split[1], input);
    }

    public String selectAndInvokeJs(Element el, String query) {
        return selectAndInvokeJs(el, query, getContentType(query, ContentType.TEXT));
    }

    /**
     * 根据查询条件选择元素并执行可能的 JS 脚本
     * <p>
     * 等价于 func(document.select(query).(text|html|attr)())
     */
    public String selectAndInvokeJs(Element el, String query, ContentType contentType) {
        if (StrUtil.isEmpty(query) || contentType == null) {
            return "";
        }

        Map<String, String> queryInfo = splitQuery(query);
        String actualQuery = queryInfo.get("query");

        // 根据查询条件选择元素
        Elements els = select(el, actualQuery);
        if (els.isEmpty()) return "";

        // 获取选中元素的内容
        Object element = els.size() == 1 ? els.first() : els;
        String result = "";
        if (ATTR_SEPARATOR.equals(queryInfo.get("actionType"))) {
            result = getContentByType(element, ATTR_ANY, queryInfo.get("action"));
        } else if (JS_SEPARATOR.equals(queryInfo.get("actionType"))) {
            // 如果查询条件包含 JS，调用它
            result = invokeJs(query, getContentByType(element, contentType, ""));
        } else if (REGEXP_SEPARATOR.equals(queryInfo.get("actionType"))) {
            // 如果查询条件包含正则表达式，应用它
            Pattern p = Pattern.compile(queryInfo.get("action"));
            Matcher m = p.matcher(getContentByType(element, HTML, ""));
            String needText = "";
            while (m.find()) {
                for (int i = 1; i <= m.groupCount(); i++) {
                    needText += m.group(i).trim();
                }
            }
            if (!needText.isBlank()) {
                result = needText;
                //cn.hutool.core.lang.Console.log("[D]Pattern '{}' is matched '{}'.", queryInfo.get("action"), needText);
            } else {
                cn.hutool.core.lang.Console.log("[D]Pattern '{}' is NOT matched '{}'!", queryInfo.get("action"), needText);
            }
        } else {
            result = getContentByType(element, contentType, "");
        }

        return result;
    }

    /**
     * 获取元素的内容并执行可能的 JS
     * <p>
     * 等价于 func(element.(text|html|attr)())
     */
    public String getStrAndInvokeJs(Element el, String js, ContentType contentType) {
        // 先获取元素的内容
        String result = getContentByType(el, contentType);
        // 如果查询条件包含 JS，调用它
        return StrUtil.isNotEmpty(js) ? invokeJs(js, result) : result;
    }

    public ContentType getContentType(String query, ContentType defContentType) {
        if (StrUtil.isEmpty(query)) {
            return defContentType;
        }
        ContentType contentType = defContentType;
        if (query.startsWith("meta[")) {
            contentType = ContentType.ATTR_CONTENT;
        } else if (query.endsWith("img") || query.lastIndexOf("img@") >= 0) {
            contentType = ContentType.ATTR_SRC;
        }

        return contentType;
    }

    public ContentType getContentType(String query) {
        return getContentType(query, ContentType.TEXT);
    }

    public Map<String, String> splitQuery(String query) {
        HashMap<String, String> map = new HashMap<>();
        Pattern pattern = Pattern.compile(SEPARATOR_PATTERN);
        Matcher matcher = pattern.matcher(query);
        if (matcher.find()) {
            map.put("query", query.substring(0, matcher.start()).trim());
            map.put("action", query.substring(matcher.end()).trim());
            map.put("actionType", matcher.group());
        } else {
            map.put("query", query.trim());
            map.put("action", "");
            map.put("actionType", "");
        }

        return map;
    }

    /**
     * 提取内容的公共方法
     */
    private String getContentByType(Object obj, ContentType contentType, String attribute) {
        String result = "";
        if (obj instanceof Element el) {
            if (contentType == ATTR_ANY) {
                if (attribute.toLowerCase().contains(ATTR_SRC.getValue()) || attribute.toLowerCase().contains(ATTR_HREF.getValue())) {
                    result = el.absUrl(attribute);
                } else {
                    result = el.attr(attribute);
                }
            } else {
                result = switch (contentType) {
                    case TEXT -> el.text();
                    case HTML -> el.html();
                    case ATTR_SRC -> el.absUrl(ATTR_SRC.getValue());
                    case ATTR_HREF -> el.absUrl(ATTR_HREF.getValue());
                    // 以下 2 个切勿改为 absUrl
                    case ATTR_CONTENT -> el.attr(ATTR_CONTENT.getValue());
                    case ATTR_VALUE -> el.attr(ATTR_VALUE.getValue());
                    case ATTR_ANY -> el.attr(attribute);
                };
            }
        } else if (obj instanceof Elements els) {
            result = switch (contentType) {
                case TEXT -> els.text();
                case HTML -> els.html();
                case ATTR_SRC -> els.attr(ATTR_SRC.getValue());
                case ATTR_HREF -> els.attr(ATTR_HREF.getValue());
                case ATTR_CONTENT -> els.attr(ATTR_CONTENT.getValue());
                case ATTR_VALUE -> els.attr(ATTR_VALUE.getValue());
                case ATTR_ANY -> els.attr(attribute);
            };
        }

        return result;
    }

    private String getContentByType(Object obj, ContentType contentType) {
        return getContentByType(obj, contentType, "");
    }

    /**
     * 清除所有元素及其子元素的属性，防止标签与属性间的空格干扰解析。
     */
    public static void clearAllAttributes(Elements elements) {
        for (Element el : elements.select("*")) {
            el.clearAttributes();
        }
    }
}