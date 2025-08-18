package com.ideaflow.noveldownload.novel.util;

import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FormatUtils {
    private static final Pattern datePattern = Pattern.compile("(\\d{2,4})[^0-9](\\d{1,2})[^0-9](\\d{1,2})(?:[ T](\\d{1,2}):(\\d{1,2}):*(\\d*)){0,1}");

    public static String formatDate(Date date, String format) {
        if (date == null) {
            date = Calendar.getInstance().getTime();
        }

        String formattedStr = "";
        if (format == null || format.isEmpty()) {
            // 如果没有指定格式，默认使用 "yyyy-MM-dd"
            formattedStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
        } else {
            // 如果指定了格式，使用指定的格式进行格式化
            formattedStr = new java.text.SimpleDateFormat(format).format(date);
        }
        
        return formattedStr;
    }

    public static Date parseDate(String dateString, String format) {
        if (dateString == null || dateString.isEmpty()) {
            return null;
        }

        Date date = null;
        try {
            if (format == null || format.isEmpty()) {
                // 如果没有指定格式，默认使用正则表达式解析
                Matcher matcher = datePattern.matcher(dateString);
                if (matcher.matches()) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.set(Calendar.YEAR, FormatUtils.parseInt(matcher.group(1), 1900)); //年を設定
                    calendar.set(Calendar.MONTH, FormatUtils.parseInt(matcher.group(2), 1) - 1); //月を設定(※MONTHは0始まり 0→Jan、1→Feb、...になる)
                    calendar.set(Calendar.DAY_OF_MONTH, FormatUtils.parseInt(matcher.group(3), 1));//日を設定
                    calendar.set(Calendar.HOUR_OF_DAY, FormatUtils.parseInt(matcher.group(4), 0)); //時を設定
                    calendar.set(Calendar.MINUTE, FormatUtils.parseInt(matcher.group(5), 0)); //分を設定
                    calendar.set(Calendar.SECOND, FormatUtils.parseInt(matcher.group(6), 0)); //秒を設定
                    date = calendar.getTime();
                }
            } else {
                // 如果指定了格式，使用指定的格式进行解析
                date = new java.text.SimpleDateFormat(format).parse(dateString);
            }
        } catch (java.text.ParseException e) {
            log.warn("Date string: {}, {}", dateString, e.getLocalizedMessage());
        }

        return date;
    }

    public static int parseInt(String str, int defaultValue) {
        if (str == null || str.isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return defaultValue;
        }
    }

    public static long parseLong(String str, int defaultValue) {
        if (str == null || str.isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return defaultValue;
        }
    }

    public static double parseDouble(String str, double defaultValue) {
        if (str == null || str.isEmpty()) {
            return defaultValue;
        }
        try {
            return Double.parseDouble(str);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return defaultValue;
        }
    }

}
