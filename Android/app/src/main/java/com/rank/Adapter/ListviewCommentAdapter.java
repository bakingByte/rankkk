package com.rank.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.rank.R;
import com.rank.models.CommentDetails;

import java.util.ArrayList;

/**
 * Created by ankita-pc on 7/7/17.
 */

public class ListviewCommentAdapter extends BaseAdapter {
    LayoutInflater inflter;
    ArrayList<CommentDetails> commentList;
    CommentDetails model;

    public ListviewCommentAdapter(Context applicationContext, ArrayList<CommentDetails> commentList) {

        inflter = (LayoutInflater.from(applicationContext));

        this.commentList = commentList;
    }

    @Override
    public int getCount() {
        return commentList.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View view, ViewGroup parent) {
        Holder holder;


        if (view == null) {
            model = commentList.get(position);
            holder = new Holder();
            view = inflter.inflate(R.layout.listview_comment, null);
            holder.tv_username = (TextView) view.findViewById(R.id.tv_username);
            holder.tv_usercomment = (TextView) view.findViewById(R.id.tv_usercomment);
            holder.iv_user = (ImageView) view.findViewById(R.id.iv_user);

//            holder.tv_username.setText(model.get());
            holder.tv_usercomment.setText(model.getComment());
//            holder.iv_user.setText(model.getDesc());

        }

        return view;
    }

    public class Holder {
        TextView tv_username, tv_usercomment;
        ImageView iv_user;
    }
}

