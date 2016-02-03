package com.ssqian.signature.open.action.test;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class TestJson
{
    // json×Ö·û´®×ª
    private static String diskListContent =
        "[{\"n1\":\"asd\",\"n2\":22,\"n3\":\"45.40GB\"," + "\"n4\":\"qwerty\",\"n5\":\"asd\",}," + "{\"n1\":\"local\","
            + "\"n2\":1,\"n3\":\"279.40GB\",\"n4\":\"ST3300656SS\",\"n5\":\"\\/devm\\/d0\"}]";
    /***
     * json×Ö·û´®×ªjava List
     * @param rsContent
     * @return
     * @throws Exception
     */
    private static List<Map<String, String>> jsonStringToList(String rsContent) throws Exception
    {
        JSONArray arry = JSONArray.fromObject(rsContent);
        System.out.println("json×Ö·û´®ÄÚÈÝÈçÏÂ");
        System.out.println(arry);
        List<Map<String, String>> rsList = new ArrayList<Map<String, String>>();
        for (int i = 0; i < arry.size(); i++)
        {
            JSONObject jsonObject = arry.getJSONObject(i);
            Map<String, String> map = new HashMap<String, String>();
            for (Iterator<?> iter = jsonObject.keys(); iter.hasNext();)
            {
                String key = (String) iter.next();
                String value = jsonObject.get(key).toString();
                map.put(key, value);
            }
            rsList.add(map);
        }
        return rsList;
    }
    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception
    {
    	
    	//String str="request=%7B%22request%22%3A%7B%22content%22%3A%7B%22AloneSign%22%3A0%2C%22fileContent%22%3A%22%22%2C%22filepath%22%3A%22public%2FS0000000000000000017%2FRr89kz24095850.doc_des%22%2C%22UserfileType%22%3A2%2C%22OrderSign%22%3A1%2C%22userlist%22%3A%5B%7B%22emailtitle%22%3A%22aa%3F%3F++*%26%5E%25%23%40%23%21%7E++%3E%3E%3F%2F%2F+++%7C%2B_**%26%25%24%22%2C%22sxdays%22%3A30%2C%22name%22%3A%22%E4%B8%A5%E6%B5%B7%22%2C%22isvideo%22%3A0%2C%22emailcontent%22%3A%22dafs_+_--+__-%3D1%6032w21%7E%7E%21%21%40%23%24%25%5E%26*%28%29_%28*%26%5E%25%24%23%22%2C%22mobile%22%3A%2215996346398%22%2C%22email%22%3A%22seaofsalt%40163.com%22%2C%22type%22%3A1%2C%22selfsign%22%3A1%7D%5D%7D%7D%7D";
    	String str="request=%7B%22request%22%3A%7B%22content%22%3A%7B%22AloneSign%22%3A0%2C%22fileContent%22%3A%22%22%2C%22filepath%22%3A%22public%2FS0000000000000000017%2FRr89kz24095850.doc_des%22%2C%22UserfileType%22%3A2%2C%22OrderSign%22%3A1%2C%22userlist%22%3A%5B%7B%22emailtitle%22%3A%22aa%3F%3F%20%20%2A%26%5E%25%23%40%23%21%7E%20%20%3E%3E%3F%2F%2F%20%20%20%7C%2B_%2A%2A%26%25%24%22%2C%22sxdays%22%3A30%2C%22name%22%3A%22%E4%B8%A5%E6%B5%B7%22%2C%22isvideo%22%3A0%2C%22emailcontent%22%3A%22dafs_%20_--%20__-%3D1%6032w21%7E%7E%21%21%40%23%24%25%5E%26%2A%28%29_%28%2A%26%5E%25%24%23%22%2C%22mobile%22%3A%2215996346398%22%2C%22email%22%3A%22seaofsalt%40163.com%22%2C%22type%22%3A1%2C%22selfsign%22%3A1%7D%5D%7D%7D%7D";
    	
    	
    	//System.out.println(new java.net.URI(str).getPath());
    	str=URLDecoder.decode(str,"UTF-8");
    	
    	
    	str=URLEncoder.encode(str,"UTF-8");
    	String  str1=str.replaceAll("\\+", "%20");
    	
    	String  str2=str1.replaceAll("\\*", "%2A");
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
        List<Map<String, String>> list1 = jsonStringToList(diskListContent);
        System.out.println("json×Ö·û´®³Émap");
        for (Map<String, String> m : list1)
        {
            System.out.println(m);
        }
        System.out.println("map×ª»»³Éjson×Ö·û´®");
        for (Map<String, String> m : list1)
        {
            JSONArray jsonArray = JSONArray.fromObject(m);
            System.out.println(jsonArray.toString());
        }
        System.out.println("list×ª»»³Éjson×Ö·û´®");
        JSONArray jsonArray2 = JSONArray.fromObject(list1);
        System.out.println(jsonArray2.toString());
    }
}