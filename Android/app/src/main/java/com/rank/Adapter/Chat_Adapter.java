package com.rank.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.rank.R;

/**
 * Created by faiz on 1/7/17.
 */

public abstract class Chat_Adapter  extends BaseAdapter {


    public View.OnClickListener relativeLayoutListener;

    Context mContext;
    LayoutInflater inflter;

    ImageView iv_dot;

    RelativeLayout rl_dot;

    public Chat_Adapter(Context applicationContext)
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
        return 5;
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

        view= inflter.inflate(R.layout.list_chat,null);

       rl_dot=(RelativeLayout)view.findViewById(R.id.rl_dot);

        iv_dot=(ImageView)view.findViewById(R.id.iv_dots1);

        rl_dot.setTag(position);
        rl_dot.setOnClickListener(relativeLayoutListener);
        return view;
    }
}
