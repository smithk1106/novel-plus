package com.ideaflow.noveldownload.constans;
/**
 * 小说分类枚举
 */
public enum EnumBookCategory {
    UNKNOWN(0, "其它"),
    FANTASY(1, "玄幻,奇幻,修真"),
    XIANXIA(2, "武侠,仙侠"),
    ROMANCE(3, "现代,言情,古言,现言,幻言,都市"),
    HISTORY(4, "历史,军事"),
    SCIENCE_FICTION(5, "科幻,灵异"),
    GAME(6, "游戏,网游"),
    COMEDY(7, "女生,女频"),
    MODERN(8, "体育,竞技"),
    YOUNGER(9, "青春,校园"),
    TIMETRAVEL(10, "穿越,重生"),
    MYSTERY(11, "恐怖,悬疑,侦探"),
    LASTDAYS(12, "末世,病毒,丧尸");

    private final int code;
    private final String description;

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    EnumBookCategory(int code, String description) {
        this.code = code;
        this.description = description;
    }
}
