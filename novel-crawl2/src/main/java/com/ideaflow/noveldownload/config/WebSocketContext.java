package com.ideaflow.noveldownload.config;

import com.ideaflow.noveldownload.websocket.websocketcore.sender.WebSocketMessageSender;

public class WebSocketContext {
    private static final ThreadLocal<WebSocketMessageSender> threadLocalSender = new ThreadLocal<>();
    // 创建一个 ThreadLocal，用来存储每个线程独立的 String 值
    private static final ThreadLocal<String> sessionId = new ThreadLocal<>();

    // 停止标志。因为WS断开重新连接后会丢失SessionID，所以这里的ID用小说URL代替
    private static String needStopTaskId = "";

    /** 设定停止标志 */
    public static void stop(String id) {
        needStopTaskId = id;
    }

    /** 清除停止标志 */
    public static void clearStopFlag() {
        needStopTaskId = "";
    }

    /** 是否停止指定任务 */
    public static boolean isNeedStop(String id) {
        return needStopTaskId.equalsIgnoreCase(id);
    }

    // 设置当前线程的 String 变量
    public static void setSessionId(String value) {
        sessionId.set(value);
    }

    // 获取当前线程的 String 变量
    public static String getSessionId() {
        return sessionId.get();
    }

    // 清除当前线程的 String 变量
    public static void clearSessionId() {
        sessionId.remove();
    }

    // 设置 WebSocketMessageSender 到当前线程
    public static void setSender(WebSocketMessageSender webSocketMessageSender) {
        threadLocalSender.set(webSocketMessageSender);
    }

    // 获取当前线程的 WebSocketMessageSender
    public static WebSocketMessageSender getSender() {
        return threadLocalSender.get();
    }

    // 清除当前线程的 WebSocketMessageSender
    public static void clearSender() {
        threadLocalSender.remove();
    }
}