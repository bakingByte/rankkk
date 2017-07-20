package com.rank.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ImageView;

import com.rank.Adapter.Adapter_Communities;
import com.rank.R;

public class Communities extends AppCompatActivity implements View.OnClickListener {


    //Imageview
    ImageView iv_globe;
    ImageView iv_chat;
    ImageView iv_location;
    ImageView iv_file;
    ImageView iv_human;

    public Integer[] mThumbIds = {
            R.drawable.explore, R.drawable.camp,
            R.drawable.climb, R.drawable.outdoor,
            R.drawable.mountain_adventure, R.drawable.mountain_hiking,
            R.drawable.bike, R.drawable.peak,
            R.drawable.explore, R.drawable.camp,
            R.drawable.climb, R.drawable.outdoor,
            R.drawable.mountain_adventure, R.drawable.mountain_hiking,
            R.drawable.bike, R.drawable.peak
    };


    @Override


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_communities);

       initialise();



    }

    public void initialise()
    {
        //Imageview
        iv_globe=(ImageView)findViewById(R.id.iv_globe);
        iv_location=(ImageView)findViewById(R.id.iv_location);
        iv_file=(ImageView)findViewById(R.id.iv_file);
        iv_human=(ImageView)findViewById(R.id.iv_human);

        //setOnClicklIstener
        iv_globe.setOnClickListener(this);
        iv_location.setOnClickListener(this);
        iv_file.setOnClickListener(this);
        iv_human.setOnClickListener(this);

        GridView gridView=(GridView)findViewById(R.id.gridview) ;
        Adapter_Communities  communities=new Adapter_Communities(getApplicationContext(),mThumbIds);
        gridView.setAdapter(communities);

        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {


                Intent i = new Intent(Communities.this, Chef.class);


                startActivity(i);

            }
        });

    }

    @Override
    public void onClick(View view) {
        switch (view.getId())
        {
            case R.id.iv_globe:
                Intent globe=new Intent(this,MainActivity.class);
                startActivity(globe);
                break;

            case R.id.iv_human:
                Intent profile=new Intent(this,Profile.class);
                startActivity(profile);
                break;
            case R.id.iv_file:
                Intent notification=new Intent(this,Notifications.class);
                startActivity(notification);
                break;

        }
    }
}
