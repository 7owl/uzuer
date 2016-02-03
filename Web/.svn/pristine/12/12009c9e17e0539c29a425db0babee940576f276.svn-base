/**
 * Copyright(c) 2005 zjhcsoft Techonologies, Ltd.
 *
 * History:
 *   2010-3-4 14:10:33 Created by Tiwen
 */
package com.lingtong.util;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.configuration.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 



/**
 * 系统配置文件参获取类
 *
 * @author
 * @version 1.0 2010-3-4 14:10:33
 */
public class SystemConfiguration
{
    private static Logger log = LoggerFactory.getLogger(SystemConfiguration.class);

    private static SystemConfiguration systemConfiguration = new SystemConfiguration();

    private static List<String> locations;

    private SystemConfiguration()
    {

    }

    public static SystemConfiguration getInstance()
    {
        if (!isRead) {
            reload();
            isRead = true;
        }
        return systemConfiguration;
    }

    /**
     * 重新加载配置文件
     */
    public static void reload()
    {
        if (locations == null) {
            log.warn("没有配置文件，无法读取");
            return;
        }
        //预先清空原先的配置集合
        compositeConfiguration.clear();
        Configuration conf = null;
        int index = 0;
        int count = 0;

        for (String location : locations) {
            if (isValid(location)) {
                try {
                    log.debug("开始读取系统配置文件[{}]", location);

                    if (location.toLowerCase().endsWith(".xml")) {
                        conf = new XMLConfiguration(location);
                    }
                    else {
                        conf = new PropertiesConfiguration(location);
                    }

                    compositeConfiguration.addConfiguration(conf);
                    index = 0;
                    for (Iterator<String> it = conf.getKeys(); it.hasNext(); ) {
                        index++;
                        count++;
                        String key = it.next();
                        log.debug("配置文件信息：[key = {} , value = {} ]", key, conf.getString(key));
                    }
                    log.info("【{}】配置文件完毕，SystemConfig总共加载了 {} 个配置信息", location, index);
                }
                catch (ConfigurationException e) {
                    log.error("SystemConfiguration读取系统配置出现错误：", e);
                }
            }
        }

        log.info("所有配置文件完毕，systemConfiguration总共加载了 {} 个配置信息", count);
    }


    private static CompositeConfiguration compositeConfiguration = new CompositeConfiguration();

    private static boolean isRead = false;

    /**
     * 读取key，返回boolean结果，如果没有找到对应键值，则返回false
     * @param key   键
     * @return boolean结果
     */
    public static boolean getBoolean(String key)
    {
        return getBoolean(key, false);
    }

    /**
     * 读取key，返回boolean结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return boolean结果
     */
    public static boolean getBoolean(String key, boolean defaultValue)
    {
        return compositeConfiguration.getBoolean(key, defaultValue);
    }

    /**
     * 读取key，返回字符串结果，如果没有找到对应键值，则返回null
     * @param key   键
     * @return 键值字符串
     */
    public static String getString(String key)
    {
        return getString(key, null);
    }

    /**
     * 读取key，返回字符串结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值字符串
     */
    public static String getString(String key, String defaultValue)
    {
        return compositeConfiguration.getString(key, defaultValue);
    }

    /**
     * 读取key，返回int结果，如果没有找到对应键值，则返回0
     * @param key   键
     * @return 键值
     */
    public static int getInt(String key)
    {
        return getInt(key, 0);
    }

    /**
     * 读取key，返回int结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static int getInt(String key, int defaultValue)
    {
        return compositeConfiguration.getInt(key, defaultValue);
    }

    /**
     * 读取key，返回double结果，如果没有找到对应键值，则返回0f
     * @param key   键
     * @return 键值
     */
    public static double getDouble(String key)
    {
        return getDouble(key, 0d);
    }

    /**
     * 读取key，返回double结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static double getDouble(String key, double defaultValue)
    {
        return compositeConfiguration.getDouble(key, defaultValue);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回0
     * @param key   键
     * @return 键值
     */
    public static byte getByte(String key)
    {
        return getByte(key, (byte) 0);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static byte getByte(String key, byte defaultValue)
    {

        return compositeConfiguration.getByte(key, defaultValue);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回0f
     * @param key   键
     * @return 键值
     */
    public static float getFloat(String key)
    {
        return getFloat(key, 0f);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static float getFloat(String key, float defaultValue)
    {
        return compositeConfiguration.getFloat(key, defaultValue);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回0l
     * @param key   键
     * @return 键值
     */
    public static long getLong(String key)
    {
        return getLong(key, 0l);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static long getLong(String key, long defaultValue)
    {
        return compositeConfiguration.getLong(key, defaultValue);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回0
     * @param key   键
     * @return 键值
     */
    public static short getShort(String key)
    {
        return getShort(key, (short) 0);
    }

    /**
     * 读取key，返回key结果，如果没有找到对应键值，则返回默认值
     * @param key   键
     * @param defaultValue  默认值
     * @return 键值
     */
    public static short getShort(String key, short defaultValue)
    {
        return compositeConfiguration.getShort(key, defaultValue);
    }

    public List<String> getLocations()
    {
        return locations;
    }

    public void setLocations(List<String> locations)
    {
        this.locations = locations;
    }
    
    private static boolean isValid(String value)
    {
      return (value != null) && (value.length() > 0);
    }
}
