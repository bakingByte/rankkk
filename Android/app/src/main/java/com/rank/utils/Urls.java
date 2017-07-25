package com.rank.utils;

import android.content.Context;

/**
 * class for key and URl of app.
 */

public class Urls {


    private static String AppBaseUrl = "http://api.rankkk.com/";
    public static String login = AppBaseUrl + "trip_" + "login?";
    public static String signup = AppBaseUrl + "trip_" + "register?";

    public static String tripPost = AppBaseUrl + "trip_" + "post";

//    http://13.126.211.132/trip_like/1?id=1


    public static String loginUrl(String username, String password) {
        return login + "email=" + username + "&" + "password=" + password;
    }

    public static String registerUrl(String username, String password) {
        return signup + "email=" + username + "&" + "password=" + password;
    }


    public static String likeDislikeUrl(String likeOrdislike, String postID, String userId) {
        return AppBaseUrl + "trip_" + likeOrdislike + "/" + postID + "?" + "id=" + userId;
    }

    public static String showCommentUrl(String postId) {
        return AppBaseUrl + "show_comment" + "/" + postId;
    }

    public static String postCommentUrl(String comment, String userId, String postId) {
        return AppBaseUrl + "trip_post/comments/store?" + "comment=" + comment + "&"
                + "user_id=" + userId + "&" + "post_id=" + postId;
    }

}
