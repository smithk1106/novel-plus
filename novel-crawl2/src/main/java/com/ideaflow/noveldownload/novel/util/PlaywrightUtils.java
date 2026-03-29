package com.ideaflow.noveldownload.novel.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

import com.ideaflow.noveldownload.novel.model.ContentType;
import com.microsoft.playwright.Browser;
import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HtmlUtil;
import lombok.experimental.UtilityClass;

@UtilityClass
public class PlaywrightUtils {

    private final static ThreadLocal<Playwright> playwright = new ThreadLocal<>();
    private final static ThreadLocal<Browser> browser = new ThreadLocal<>();

    public Page createPage(String url) {
        if (playwright.get() == null) {
            playwright.set(Playwright.create());
            browser.set(playwright.get().chromium().launch());
            browser.set(playwright.get().chromium().connect("ws://playwright:3000/"));
        }

        Page page = browser.get().newPage();
        if (StringUtils.hasText(url)) {
            page.navigate(url);
        }

        return page;
    }

    public void close() {
        if (browser.get() != null) {
            browser.get().close();
            browser.set(null);
        }
        if (playwright.get() != null) {
            playwright.get().close();
            playwright.set(null);
        }
    }

    public String queryContent(Page page, String query, boolean isVisible) {
        return queryContent(page, query, isVisible, ContentType.HTML);
    }

    public String queryContent(Page page, String query, boolean isVisible, ContentType contentType) {
        if (StrUtil.isEmpty(query)) return "";

        Map<String, String> queryInfo = JsoupUtils.splitQuery(query);
        String actualQuery = queryInfo.get("query");

        // 根据查询条件选择元素
        Locator el = page.locator(actualQuery);
        if (isVisible && el.count() == 1 && el.isHidden()) return "";

        // 获取选中元素的内容
        String result = "";
        if (JsoupUtils.ATTR_SEPARATOR.equals(queryInfo.get("actionType"))) {
            // 多个元素存在时只取第一个（可见的）元素
            Locator elFirst = getFirst(el, isVisible);
            if (elFirst != null) {
                result = elFirst.getAttribute(queryInfo.get("action"));
            }
        } else if (JsoupUtils.JS_SEPARATOR.equals(queryInfo.get("actionType"))) {
            // 多个元素存在时只取第一个（可见的）元素
            Locator elFirst = getFirst(el, isVisible);
            if (elFirst != null) {
                // 如果查询条件包含 JS，调用它
                result = (String)elFirst.evaluate(queryInfo.get("action"));
            }
        } else if (JsoupUtils.REGEXP_SEPARATOR.equals(queryInfo.get("actionType"))) {
            // 多个元素存在时只取第一个（可见的）元素
            Locator elFirst = getFirst(el, isVisible);
            if (elFirst != null) {
                // 如果查询条件包含正则表达式，应用它
                Pattern p = Pattern.compile(queryInfo.get("action"));
                Matcher m = p.matcher(elFirst.innerHTML());
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
            }
        } else {
            for (Locator brother : el.all()) {
                if (!isVisible || (isVisible && brother.isVisible())) {
                    List<Locator> children = brother.locator("> *").all();
                    for (Locator child : children) {
                        if (!isVisible || (isVisible && child.isVisible())) {
                            if (contentType == ContentType.HTML) {
                                result += (String)child.evaluate("el => el.outerHTML");
                            } else {
                                // display: none和visibility: hidden等要素会自动被删除
                                result += child.textContent() + "\n";
                            }
                        }
                    }
                }
            }
        }

        return result;
    }

    private Locator getFirst(Locator element, boolean isVisible) {
        Locator firstElement = null;

        if (isVisible) {
            for (Locator brother : element.all()) {
                if (brother.isVisible()) {
                    firstElement = brother;
                    break;
                }
            }
        } else {
            firstElement = element.first();
        }

        return firstElement;
    }
}
