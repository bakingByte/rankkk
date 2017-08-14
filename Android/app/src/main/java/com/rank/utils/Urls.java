package com.rank.utils;

import android.content.Context;

/**
 * class for key and URl of app.
 */

public class Urls {



     private static String AppBaseUrl="http://13.126.211.132/trip_";
    public static String login=AppBaseUrl+"login?";
    public static String signup=AppBaseUrl+"register?";


    public static String loginUrl(String username,String password){
        return login+"email="+username+"&"+"password="+password;
    }

    public static String registerUrl(String username,String password){
        return signup+"email="+username+"&"+"password="+password;
    }



}
