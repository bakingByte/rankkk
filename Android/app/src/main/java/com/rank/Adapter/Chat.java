package com.rank.Adapter;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.rank.activity.Communities;
import com.rank.activity.MainActivity;
import com.rank.activity.Notifications;
import com.rank.activity.Profile;
import com.rank.R;

public class Chat extends AppCompatActivity implements View.OnClickListener {

    //Imageview
    ImageView iv_globe;
    ImageView iv_chat;
    ImageView iv_location;
    ImageView iv_file;
    ImageView iv_human;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chat);
       initialise();

    }

    public void initialise()
    {
        //Imageview
        iv_globe=(ImageView)findViewById(R.id.iv_globe);
        iv_chat=(ImageView)findViewById(R.id.iv_chat);
        iv_location=(ImageView)findViewById(R.id.iv_location);
        iv_file=(ImageView)findViewById(R.id.iv_file);
        iv_human=(ImageView)findViewById(R.id.iv_human);

        //setOnClicklIstener
        iv_globe.setOnClickListener(this);
        iv_chat.setOnClickListener(this);
        iv_location.setOnClickListener(this);
        iv_file.setOnClickListener(this);
        iv_human.setOnClickListener(this);

        ListView listView =(ListView)findViewById(R.id.listview);
        Chat_Adapter listview_adapter= new Chat_Adapter(getApplicationContext()) {
            @Override
            protected void onCancelClick(View v, String s) {
                   cancel();
            }
        };
        listView.setAdapter(listview_adapter);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId())
        {
            case R.id.iv_globe:
                Intent globe=new Intent(this,MainActivity.class);
                startActivity(globe);
                break;

            case R.id.iv_location:
                Intent location=new Intent(this,Communities.class);
                startActivity(location);
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


    private void cancel() {

        final Dialog dialog = new Dialog(this, android.R.style.Theme_Translucent_NoTitleBar);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(R.layout.cancel_dialog);
        Window window = dialog.getWindow();
        WindowManager.LayoutParams wlp = window.getAttributes();

        wlp.gravity = Gravity.CENTER;
        wlp.flags &= ~WindowManager.LayoutParams.FLAG_BLUR_BEHIND;
        window.setAttributes(wlp);
        dialog.getWindow().setLayout(WindowManager.LayoutParams.FILL_PARENT, WindowManager.LayoutParams.MATCH_PARENT);
        dialog.show();


        TextView tvDisturb = (TextView) dialog.findViewById(R.id.tv_disturb);
        TextView tvHide = (TextView) dialog.findViewById(R.id.tv_hide);
        TextView tvCancel = (TextView) dialog.findViewById(R.id.tv_cancel);






        dialog.show();


        tvCancel.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {



                    dialog.dismiss();



            }
        });

        tvHide.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });


        tvDisturb.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });

      /*  ivEdit.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view)
            {
                etLocation.setEnabled(true);
            }
        });*/

    }
}
