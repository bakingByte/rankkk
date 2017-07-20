package com.rank.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;

import com.rank.R;

public class Notifications extends AppCompatActivity implements View.OnClickListener {


    //Imageview
    ImageView iv_globe;
    ImageView iv_chat;
    ImageView iv_location;
    ImageView iv_notification;
    ImageView iv_profile;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notifications);

        //Imageview
        iv_globe = (ImageView) findViewById(R.id.iv_globe);

        iv_location = (ImageView) findViewById(R.id.iv_location);
        iv_notification = (ImageView) findViewById(R.id.iv_file);
        iv_profile= (ImageView) findViewById(R.id.iv_human);

        //setOnClicklIstener
        iv_globe.setOnClickListener(this);

        iv_location.setOnClickListener(this);
        iv_notification.setOnClickListener(this);
        iv_profile.setOnClickListener(this);

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {

            case R.id.iv_location:
                Intent location = new Intent(this, Communities.class);
                startActivity(location);
                break;
            case R.id.iv_globe:
                Intent notification = new Intent(this, MainActivity.class);
                startActivity(notification);
                break;
            case R.id.iv_human:
                Intent profile = new Intent(this, Profile.class);
                startActivity(profile);
                break;

        }

    }
}
