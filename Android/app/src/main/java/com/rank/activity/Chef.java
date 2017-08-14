package com.rank.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.rank.Adapter.Adapter_chef;
import com.rank.Adapter.Listview_Adapter;
import com.rank.Adapter.ViewPagerAdapter_FemaleChef;
import com.rank.Adapter.ViewPagerAdapter_MaleChef;
import com.rank.helper.ExpandableHeightGridView;
import com.rank.R;

public class Chef extends AppCompatActivity implements View.OnClickListener {


    ListView listView;
    int[] malechef;
    int[] femalechef;
    ViewPager pager;
    public ViewPagerAdapter_MaleChef Male_adapter;
    public ViewPagerAdapter_FemaleChef female_adapter;
    ViewPager    femalepager;


    //Imageview
    ImageView iv_globe;
    ImageView iv_location;
    ImageView iv_file;
    ImageView iv_human;

    //RelativeLayout
    RelativeLayout rlBack;

    //Textview
    TextView tv_world;
    TextView tv_country;
    TextView tv_city;


    public Integer[] mThumbIds = {
            R.drawable.img1, R.drawable.img2,
            R.drawable.img3, R.drawable.img4,
            R.drawable.img5, R.drawable.img6,
            R.drawable.img7, R.drawable.img8,
            R.drawable.img9

    };

    public static int PAGES ;
    // You can choose a bigger number for LOOPS, but you know, nobody will fling
    // more than 1000 times just in order to test your "infinite" ViewPager :D
    public final static int LOOPS = 1000;
    public  static int FIRST_PAGE;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chef);


   initialise();


    }


    public void initialise()
    {


        //TextView
        tv_world=(TextView)findViewById(R.id.tv_world);
        tv_country=(TextView)findViewById(R.id.tv_country);
        tv_city=(TextView)findViewById(R.id.tv_city);

        //Listview
        listView=(ListView)findViewById(R.id.listview);

        ExpandableHeightGridView gridView=(ExpandableHeightGridView)findViewById(R.id.gridview) ;
        Adapter_chef chef=new Adapter_chef(getApplicationContext(),mThumbIds);
        gridView.setAdapter(chef);
        gridView.setExpanded(true);

        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {


                Intent i = new Intent(Chef.this, Post.class);


                startActivity(i);

            }
        });


        Listview_Adapter listview_adapter=new Listview_Adapter(getApplicationContext()){
            @Override
            protected void onCancelClick(View v, String s) {

                Intent i=new Intent(Chef.this, Comment.class);
                startActivity(i);
            }
        };
        listView.setAdapter(listview_adapter);
        setListViewHeightBasedOnChildren(listView);

        //ViewPager
        pager = (ViewPager)findViewById(R.id.myviewpager);
        femalepager = (ViewPager)findViewById(R.id.femaleviewpager);

        malechef = new int[] { R.drawable.malechef1, R.drawable.malechef1,
                R.drawable.malechef1, R.drawable.malechef2,
                R.drawable.malechef3, R.drawable.malechef2,
                R.drawable.malechef3, R.drawable.malechef2,
                R.drawable.malechef3, R.drawable.malechef2
        };


        femalechef = new int[] { R.drawable.femalechef1, R.drawable.femalechef1,
                R.drawable.femalechef1, R.drawable.femalechef2,
                R.drawable.femalechef3, R.drawable.femalechef2,
                R.drawable.femalechef3, R.drawable.femalechef2,
                R.drawable.femalechef3, R.drawable.femalechef2
        };

        //ViewPagerAdapter

        Male_adapter = new ViewPagerAdapter_MaleChef(Chef.this, malechef );
        female_adapter = new ViewPagerAdapter_FemaleChef(Chef.this, femalechef );


        pager.setAdapter(Male_adapter);
        pager.setOffscreenPageLimit(3);
        pager.setClipToPadding(false);
       // pager.setPageMargin(-370);
        pager.setCurrentItem(FIRST_PAGE);

        femalepager.setAdapter(female_adapter);
        femalepager.setOffscreenPageLimit(3);
        femalepager.setClipToPadding(false);
        //femalepager.setPageMargin(-370);
        femalepager.setCurrentItem(FIRST_PAGE);


        //Imageview
        iv_globe=(ImageView)findViewById(R.id.iv_globe);
        iv_location=(ImageView)findViewById(R.id.iv_location);
        iv_file=(ImageView)findViewById(R.id.iv_file);
        iv_human=(ImageView)findViewById(R.id.iv_human);

        //RelativeLayout
        rlBack=(RelativeLayout)findViewById(R.id.rl_back);

        //setOnClicklIstener
        iv_globe.setOnClickListener(this);
        iv_location.setOnClickListener(this);
        iv_file.setOnClickListener(this);
        iv_human.setOnClickListener(this);
        tv_world.setOnClickListener(this);
        tv_country.setOnClickListener(this);
        tv_city.setOnClickListener(this);
        rlBack.setOnClickListener(this);



    }


    public static void setListViewHeightBasedOnChildren(ListView listView) {
        Listview_Adapter listAdapter = (Listview_Adapter) listView.getAdapter();
        if (listAdapter == null)
            return;

        int desiredWidth = View.MeasureSpec.makeMeasureSpec(listView.getWidth(), View.MeasureSpec.UNSPECIFIED);
        int totalHeight = 0;
        View view = null;
        for (int i = 0; i < listAdapter.getCount(); i++) {
            view = listAdapter.getView(i, view, listView);
            if (i == 0)
                view.setLayoutParams(new ViewGroup.LayoutParams(desiredWidth, RelativeLayout.LayoutParams.WRAP_CONTENT));

            view.measure(desiredWidth, View.MeasureSpec.UNSPECIFIED);
            totalHeight += view.getMeasuredHeight();
        }
        ViewGroup.LayoutParams params = listView.getLayoutParams();
        params.height = totalHeight + (listView.getDividerHeight() * (listAdapter.getCount() - 1));
        listView.setLayoutParams(params);
    }




    @Override
    public void onClick(View view) {

        switch (view.getId())
        {
            case R.id.rl_back:
                finish();
                break;
            case R.id.iv_globe:
                Intent globe=new Intent(this,MainActivity.class);
                startActivity(globe);
                break;

            case R.id.iv_location:
                Intent location=new Intent(this,Communities.class);
                startActivity(location);
                break;
            case R.id.iv_file:
                Intent notification=new Intent(this,Notifications.class);
                startActivity(notification);
                break;
            case R.id.iv_human:
                Intent profile=new Intent(this,Profile.class);
                startActivity(profile);
                break;
            case R.id.tv_world:
                tv_world.setBackgroundResource(R.drawable.world);
                tv_country.setBackgroundResource(R.drawable.country1);
                tv_city.setBackgroundResource(R.drawable.state);
                break;
            case R.id.tv_country:
                tv_country.setBackgroundResource(R.drawable.country);
                tv_city.setBackgroundResource(R.drawable.state);
                tv_world.setBackgroundResource(R.drawable.world1);
                break;
            case R.id.tv_city:
                tv_city.setBackgroundResource(R.drawable.state1);
                tv_country.setBackgroundResource(R.drawable.country1);
                tv_world.setBackgroundResource(R.drawable.world1);
                break;


        }

    }
}
