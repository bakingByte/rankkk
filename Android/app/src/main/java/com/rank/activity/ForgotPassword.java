package com.rank.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.RelativeLayout;

import com.rank.R;

public class ForgotPassword extends AppCompatActivity implements View.OnClickListener{

    //RelativeLayout
    RelativeLayout rl_back;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot_password);

        //initialization
        initialization();

        //setClickListener
        setClickListener();
    }

    //initialization
    public void initialization() {

        //RelativeLayout
        rl_back           =  (RelativeLayout)findViewById(R.id.rl_back);
    }

    //setClickListener
    public void setClickListener() {

        //RelativeLayout
        rl_back.setOnClickListener(this);
    }

    @Override
    public void onBackPressed() {
      finish();
    }

    @Override
    public void onClick(View v) {

        switch (v.getId()) {

            case R.id.rl_back:
                finish();
                break;
        }

    }
}
