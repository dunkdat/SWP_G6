/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Login;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author DAT
 */
public class SendVerify {
    public String getRandom(){
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }
    
    public boolean sendEmail(String to, String code) {
        boolean test = false;
        String toEmail = to;
        String fromEmail = "badsportshop@gmail.com";
        String password = "osue vleu lsft kdhn";
        
        try{
            Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
		props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
            
            Session ss = Session.getInstance(props, new Authenticator() {
                @Override
                protected  PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication(fromEmail, password);
                }
            });
            
            MimeMessage mess = new MimeMessage(ss);
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        
             mess.setSubject("Your Verification Code");
            
            // Email content with inline CSS
           String content = "<html>" +
                 "<head><style>" +
                 "body { font-family: Arial, sans-serif; margin: 0; padding: 20px;}" +
                 "h1 { color: #333; text-align: center; }" +
                 "p { font-size: 16px; color: #555; text-align: center; }" +
                 ".container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; background-color: #f9f9f9; text-align: center; }" +
                 ".code { font-size: 36px; font-weight: bold; color: #007bff; margin: 20px 0; }" +
                 "</style></head>" +
                 "<body>" +
                 "<div class='container'>" +
                 "<h1>Hello!</h1>" +
                 "<p>Thank you for registering. Please use the following verification code to complete your registration:</p>" +
                 "<p class='code'>" + code + "</p>" +
                 "<p>If you did not request this code, please ignore this email.</p>" +
                 "</div>" +
                 "</body>" +
                 "</html>";

            
            mess.setContent(content, "text/html; charset=UTF-8");
            Transport.send(mess);
            test = true;
        }catch(Exception e){
            e.printStackTrace();
        }   
        
        
        return test;
    }
    public static void main(String[] args) {
        SendVerify s = new SendVerify();
        s.sendEmail("datnb258@gmail.com", "asdasd");
    }
}
