/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.security.MessageDigest;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author DAT
 */
public class Encode {
    public  String toSHA1(String str){
        String salt = "ohshibacaonimalmaotieulilumufuvku@$%^&*";
        String result = null;
        str = str + salt;
        try{
            byte[]  dataBytes = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            result = Base64.encodeBase64String(md.digest(dataBytes));
        }catch(Exception e){
            e.printStackTrace();
        }
        return result;
    }
    public static void main(String[] args) {
        Encode e = new Encode();
        System.out.println(e.toSHA1("12345"));
    }
}
