package com.rank.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.rank.R;

/**
 * Created by ankita-pc on 7/7/17.
 */

public class Listview_Comment_Adapter extends BaseAdapter {
    LayoutInflater inflter;

    public Listview_Comment_Adapter(Context applicationContext)
    {

        inflter = (LayoutInflater.from(applicationContext));
    }

    @Override
    public int getCount() {
        return 3;
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

        view= inflter.inflate(R.layout.listview_comment,null);

        return view;
    }
}

