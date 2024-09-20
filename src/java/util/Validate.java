/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import constant.IConstant;
import jakarta.servlet.http.Part;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ADMIN
 */
public class Validate {

    public static final boolean isValidName(String name) {
        Pattern pattern = Pattern.compile(IConstant.REGEX_NAME);
        Matcher matcher = pattern.matcher(name);
        return matcher.matches();
    }

    public static final boolean isValidEmail(String email) {
        Pattern pattern = Pattern.compile(IConstant.REGEX_EMAIL);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public static final boolean isValidAddress(String address) {
        Pattern pattern = Pattern.compile(IConstant.REGEX_ADDRESS);
        Matcher matcher = pattern.matcher(address);
        return matcher.matches();
    }

    public static final boolean isValidPhoneNumber(String phoneNumber) {
        Pattern pattern = Pattern.compile(IConstant.REGEX_PHONE_NUMBER);
        Matcher matcher = pattern.matcher(phoneNumber);
        return matcher.matches();
    }

    public static final boolean isValidPassword(String password) {
        Pattern pattern = Pattern.compile(IConstant.REGEX_PASSWORD);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

    public static final boolean  isImageFile(Part part) {
      String contentType = part.getContentType();
      return contentType.startsWith("image/");
    }
    public static final String getMd5(String input)
    {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
 
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}