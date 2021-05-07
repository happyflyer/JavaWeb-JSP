package org.example.java_web.jsp.el;

import java.util.Collection;

/**
 * 自定义 EL 函数
 *
 * @author lifei
 */
public class Util {
    public static int length(Collection collection) {
        return collection.size();
    }
}
