package com.rank.activity;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.TextView;

import com.rank.Adapter.Adapter_chef;
import com.rank.helper.ExpandableHeightGridView;
import com.rank.R;

import java.util.ArrayList;
import java.util.List;

public class Profile extends AppCompatActivity implements View.OnClickListener {

    RelativeLayout rlPopup;
    RelativeLayout rlBack,rlDots;
    ImageView ivBack,ivMenu;
    Spinner rank;
  LinearLayout linearLayout;
    List<String> rank1;

    public Integer[] mThumbIds = {
            R.drawable.img1, R.drawable.img2,
            R.drawable.img3, R.drawable.img4,
            R.drawable.img5, R.drawable.img6,
            R.drawable.img7, R.drawable.img8,
            R.drawable.img9

    };

    //Imageview
    ImageView iv_globe;
    ImageView iv_location;
    ImageView iv_file;
    ImageView iv_human;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);

         linearLayout=(LinearLayout)findViewById(R.id.linearlayout);
        rlDots=(RelativeLayout)findViewById(R.id.rl_dots) ;
        rlPopup=(RelativeLayout)findViewById(R.id.rr_popup) ;

        rank1 = new ArrayList<String>();
        rank1.add("Hide All");
        rank1.add("245,India");
        rank1.add("12455,World");
        rank1.add("245,UP,India");


        rank=(Spinner)findViewById(R.id.Spinner);

        rank.setAdapter(new spinnerAdapter(getApplicationContext(), R.layout.spinner_layout,(ArrayList<String>) rank1));
        ivBack=(ImageView)findViewById(R.id.iv_back);
        ivMenu=(ImageView)findViewById(R.id.iv_menu);
        rlBack=(RelativeLayout)findViewById(R.id.rl_back);



        //Imageview
        iv_globe=(ImageView)findViewById(R.id.iv_globe);
        iv_location=(ImageView)findViewById(R.id.iv_location);
        iv_file=(ImageView)findViewById(R.id.iv_file);
        iv_human=(ImageView)findViewById(R.id.iv_human);

        ivBack.setOnClickListener(this);
        ivMenu.setOnClickListener(this);
        rlDots.setOnClickListener(this);
        iv_globe.setOnClickListener(this);
        iv_location.setOnClickListener(this);
        iv_file.setOnClickListener(this);
        iv_human.setOnClickListener(this);


        ExpandableHeightGridView gridView=(ExpandableHeightGridView)findViewById(R.id.gridview) ;
        Adapter_chef chef=new Adapter_chef(getApplicationContext(),mThumbIds);
        gridView.setAdapter(chef);
        gridView.setExpanded(true);


        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {


                Intent i = new Intent(Profile.this, Post.class);


                startActivity(i);

            }
        });

        gridView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                v.getParent().requestDisallowInterceptTouchEvent(true);
                return false;
            }

        });

        gridView.setOnTouchListener(new GridView.OnTouchListener()
        {

            @Override
            public boolean onTouch(View v, MotionEvent event) {

                int action = event.getAction();
                switch (action) {
                    case MotionEvent.ACTION_DOWN:
                        // Disallow ScrollView to intercept touch events.
                        v.getParent().requestDisallowInterceptTouchEvent(true);
                        break;

                    case MotionEvent.ACTION_UP:
                        // Allow ScrollView to intercept touch events.
                        v.getParent().requestDisallowInterceptTouchEvent(false);
                        break;
                }

                // Handle ListView touch events.
                v.onTouchEvent(event);
                return true;
              //  return false;
            }

         /*   public boolean onTouch(View v, MotionEvent event)
            {

            }*/
        });



        rank.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                // TODO Auto-generated method stub

                //String gender= String.valueOf(pref.get(Constants.gender));
                //String item = parent.getItemAtPosition(position).toString();
                // getGendervalue();


            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }

        });
    }



    public void startblock(){

        final Dialog dg = new Dialog(this, android.R.style.Theme_Translucent_NoTitleBar);
        dg.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dg.setContentView(R.layout.alert_block);
        Window window = dg.getWindow();
        WindowManager.LayoutParams wlp = window.getAttributes();

        wlp.gravity = Gravity.RIGHT;
        wlp.flags &= ~WindowManager.LayoutParams.FLAG_BLUR_BEHIND;
        window.setAttributes(wlp);
        dg.getWindow().setLayout(WindowManager.LayoutParams.FILL_PARENT, WindowManager.LayoutParams.MATCH_PARENT);
        dg.show();
        TextView close_popup,tvReport,tvBlock,tvCancel;

        final ListView listView;

        tvReport=(TextView)dg.findViewById(R.id.tv_report);
        tvBlock=(TextView)dg.findViewById(R.id.tv_block);



        dg.show();






        tvBlock.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dg.dismiss();
            }
        });


        linearLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dg.dismiss();
            }
        });


    }







    @Override
    public void onClick(View view) {
        switch(view.getId())
        {
            case R.id.iv_back:
                Intent i=new Intent(this,MainActivity.class);
                startActivity(i);
                break;
            case R.id.rl_dots:
               startblock();
                break;
            case R.id.rr_popup:
                startblock();
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

        }

    }


    public class spinnerAdapter extends ArrayAdapter<String> {

        ArrayList<String> data;

        public spinnerAdapter(Context context, int textViewResourceId, ArrayList<String> arraySpinner_time) {

            super(context, textViewResourceId, arraySpinner_time);

            this.data = arraySpinner_time;

        }

        @Override
        public View getDropDownView(int position, View convertView, ViewGroup parent) {
            return getCustomView(position, convertView, parent);
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            return getCustomView(position, convertView, parent);
        }

        public View getCustomView(int position, View convertView, ViewGroup parent) {
            LayoutInflater inflater = LayoutInflater.from(parent.getContext());
            View row = inflater.inflate(R.layout.spinner_layout, parent, false);
            TextView label = (TextView) row.findViewById(R.id.tvName);
            //label.setTypeface(typeface);
            label.setText(data.get(position));

            return row;
        }
    }

}
