package constant;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author HP
 */
public class IConstant {
    public static final String PATH_PRODUCT = "./images/Product_img";
    public static final String PATH_TEMP = "./images/Img_Temp";
    public static final String PATH_BANK = "./images/Bank_img";
    public static final String BANNER_PATH = "./images/Banner_img";
    public static final String IMAGE_FILE = "./images";
    public static final String PATH_NEWS = "./images/News_img";
    public static final String SORT_DISCOUNT = "sort Discount";
    public static final String PRICE_ASC = "price Ascending";
    public static final String PRICE_DESC = "price Descending";
    public static final String DATE_ASC = "Date Ascending";
    public static final String DATE_DESC = "Date Descending";
    public static final String ALL_TYPE = "Tất cả";
    public static final String PATH_DOWN = "D:/allBrand.xlsx";
    public static final String PATH_BRAND = "images/Brand_img";
    public static final int HOMENEWS = 6;
    public static final int NUMBERPERPAGE = 1;
    public static final String[] SORT_OPTIONS = new String[]{"sort Discount", "price Ascending", "price Descending"};
    public static final String SIGNATURE_IMG = "./images/App_img/signature.png";
    public static final int NUMBER_PER_PAGE = 5;
    //generate password 
    public static final String LOWERCASE_CHARACTERS = "abcdefghijklmnopqrstuvwxyz";
    public static final String UPPERCASE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String NUMERIC_CHARACTERS = "0123456789";
    public static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_=+[]{}|;:'<>,.?/";

    public static final String PATH_USER = "images/User_img/";
    public static final int[] NUMBER_OPTION = new int[]{3, 5, 7, 10};
    public static final int ITEMS_PER_PAGE = 5;
    public static final String ASC = "ASC";
    public static final String DESC = "DESC";
    public static final String SORT_ASC = "Ascending";
    public static final String SORT_DESC = "Descending";
    public static final String REGEX_PHONE_NUMBER = "^0\\d{9}$";
    public static final String REGEX_PASSWORD = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$";
    public static final String REGEX_EMAIL = "^[\\w-\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
    public static final String REGEX_ADDRESS = "^[A-Za-z0-9 ,]+$";
    public static final String REGEX_TEXT = "^[A-Za-z0-9 ,\\.]+S";
    public static final String REGEX_NAME = "^[A-Za-z ]+$";
    public static final String[] ORDER_STATUS = new String[]{"Chờ xác nhận",
        "Đang vận chyển", "Đặt hàng thành công", "Đã hủy"};
    public static final String[] WARRANTY_STATUS = new String[]{"Tiếp Nhận",
        "Không tiếp nhận", "Bảo hành thành công"};
}
