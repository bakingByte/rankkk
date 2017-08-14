package com.rank.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.rank.R;

public class Post extends AppCompatActivity implements View.OnClickListener {


    RelativeLayout rlBack;

    ImageView ivComment;
    ImageView ivBack;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post);

        rlBack=(RelativeLayout)findViewById(R.id.rlBack);

        ivComment=(ImageView)findViewById(R.id.iv_comment);
        ivBack=(ImageView)findViewById(R.id.iv_back);


        ivComment.setOnClickListener(this);
        ivBack.setOnClickListener(this);
        rlBack.setOnClickListener(this);
    }


    @Override
    public void onClick(View view) {

        switch (view.getId())
        {
            case R.id.iv_comment:
                Intent comment=new Intent(this,Comment.class);
                startActivity(comment);
                break;

            case R.id.rlBack:
              finish();
                break;
        }
    }
}
