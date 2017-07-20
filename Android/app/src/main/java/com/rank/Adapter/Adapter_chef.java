package com.rank.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.rank.R;

/**
 * Created by ankita-pc on 3/7/17.
 */

public class Adapter_chef extends BaseAdapter {
    private Context mContext;

    public Integer[] mThumbIds;

    LayoutInflater inflter;
    // Constructor
    public  Adapter_chef(Context c, Integer[] mThumbIds) {
        mContext = c;
        this.mThumbIds=mThumbIds;

        inflter = (LayoutInflater.from(c));
    }

    public int getCount() {
        return mThumbIds.length;
    }

    public Object getItem(int position) {
        return null;
    }

    public long getItemId(int position) {
        return 0;
    }

    // create a new ImageView for each item referenced by the Adapter
    public View getView(int position, View view, ViewGroup parent) {

        view= inflter.inflate(R.layout.gridview_chef,null);
        ImageView imageView;


       /*        imageView = new ImageView(mContext);
        imageView.setLayoutParams(new GridView.LayoutParams(85, 50));
        imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
        imageView.setPadding(8, 8, 8, 8);
*/

        imageView = (ImageView) view.findViewById(R.id.imageview);
        imageView.setImageResource(mThumbIds[position]);

        return view;
    }

    // Keep all Images in array

}
