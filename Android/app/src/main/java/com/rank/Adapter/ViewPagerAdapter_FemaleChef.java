package com.rank.Adapter;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.rank.R;

/**
 * Created by ankita-pc on 3/7/17.
 */

public class ViewPagerAdapter_FemaleChef extends PagerAdapter {


    Context context;
    int[] femalechef;
    LayoutInflater inflater;

    public  ViewPagerAdapter_FemaleChef(Context context,
                                      int[] flag) {
        this.context = context;

        this.femalechef = flag;

        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }
    @Override
    public int getCount() {
        return femalechef.length;
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == ((LinearLayout) object);
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {

        // Declare Variables

        ImageView imgChef;

        inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View itemView = inflater.inflate(R.layout.viewpager_female_chef, container,
                false);



        // Locate the ImageView in viewpager_item.xml
        imgChef = (ImageView) itemView.findViewById(R.id.iv_femalechef);
        // Capture position and set to the ImageView
        imgChef.setImageResource(femalechef[position]);

        // Add viewpager_item.xml to ViewPager
        ((ViewPager) container).addView(itemView);

        return itemView;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        // Remove viewpager_item.xml from ViewPager
        ((ViewPager) container).removeView((LinearLayout) object);

    }

    @Override
    public float getPageWidth(int position) {
        return .35f;
    }
}
