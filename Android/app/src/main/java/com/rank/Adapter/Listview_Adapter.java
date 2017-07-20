package com.rank.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.rank.R;


public abstract class Listview_Adapter extends BaseAdapter{

    public View.OnClickListener relativeLayoutListener;

    LayoutInflater inflter;

    Context mContext;

    public Listview_Adapter(final Context applicationContext)
    {
        mContext=applicationContext;
        inflter = (LayoutInflater.from(applicationContext));
        relativeLayoutListener= new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // TODO Auto-generated method stub                /




                onCancelClick(v,String.valueOf(v.getTag()));
                  }
                 };
    }

    protected abstract void onCancelClick(View v, String s);

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

        view= inflter.inflate(R.layout.listview_mainactivity,null);


        ImageView ivComment=(ImageView)view.findViewById(R.id.iv_comment);
        ivComment.setTag(position);
        ivComment.setOnClickListener(relativeLayoutListener);
        return view;
    }
}
