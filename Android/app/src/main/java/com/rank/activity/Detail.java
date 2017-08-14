package com.rank.activity;

/**
 * Created by ankita-pc on 4/7/17.
 */

public class Detail {




    String userName,userAddress,userLike,userUnlike;

    int user_id,user_display,user_like,user_unlike,user_share,user_comment;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String name) {
        this.userName = name;
    }

    public String getUserAddress()
    {
        return userAddress;
    }

    public void setUserAddress(String address)
    {
        this.userAddress=address;
    }

    public String getUserLike()
    {
        return userLike;
    }

    public void setUserLike(String like)
    {
        this.userLike=like;
    }

    public String getUserUnLike()
    {
        return userUnlike;
    }

    public void setUserUnLike(String unlike)
    {
        this.userUnlike=unlike;
    }


    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int id) {
        this.user_id = id;
    }

    public int getUser_display() {
        return user_display;
    }
    public void setUser_display(int user_display) {
        this.user_display =  user_display;
    }

    public int getUser_like() {
        return user_like;
    }
    public void setUser_like(int user_like) {
        this.user_like =  user_like;
    }

    public int getUser_unlike() {
        return user_unlike;
    }
    public void setUser_unlike(int user_unlike) {
        this.user_unlike =  user_unlike;
    }

    public int getUser_share() {
        return user_share;
    }
    public void setUser_share(int user_share) {
        this.user_share =  user_share;
    }


    public int getUser_comment() {
        return user_comment;
    }
    public void setUser_comment(int user_comment) {
        this.user_comment =  user_comment;
    }

    public Detail(String name,String address,String like,String unlike, int id,int user_display,int user_like,int user_unlike,int user_share,int user_comment)
    {
        this.userName = name;
        this.userAddress=address;
        this.userLike=like;
        this.userUnlike=unlike;
        this.user_id = id;
        this.user_display=user_display;
        this.user_like=user_like;
        this.user_unlike=user_unlike;
        this.user_share=user_share;
        this.user_comment=user_comment;
    }
}
