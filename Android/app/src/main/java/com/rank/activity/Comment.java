package com.rank.activity;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;

import com.rank.Adapter.Listview_Comment_Adapter;
import com.rank.R;

public class Comment extends AppCompatActivity {

    ListView listview;
    ImageView ivBack;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_comment);


        ivBack=(ImageView)findViewById(R.id.iv_back);

        listview=(ListView)findViewById(R.id.listview_comment);
        Listview_Comment_Adapter listview_adapter=new Listview_Comment_Adapter(getApplicationContext());
        listview.setAdapter(listview_adapter);
        setListViewHeightBasedOnChildren(listview);
    }

     public void onClick(View view)
     {
       finish();
     }

    public static void setListViewHeightBasedOnChildren(ListView listView) {
        Listview_Comment_Adapter  listview_adapter= (Listview_Comment_Adapter ) listView.getAdapter();
        if (listview_adapter == null)
            return;

        int desiredWidth = View.MeasureSpec.makeMeasureSpec(listView.getWidth(), View.MeasureSpec.UNSPECIFIED);
        int totalHeight = 0;
        View view = null;
        for (int i = 0; i < listview_adapter.getCount(); i++) {
            view = listview_adapter.getView(i, view, listView);
            if (i == 0)
                view.setLayoutParams(new ViewGroup.LayoutParams(desiredWidth, RelativeLayout.LayoutParams.WRAP_CONTENT));

            view.measure(desiredWidth, View.MeasureSpec.UNSPECIFIED);
            totalHeight += view.getMeasuredHeight();
        }
        ViewGroup.LayoutParams params = listView.getLayoutParams();
        params.height = totalHeight + (listView.getDividerHeight() * (listview_adapter.getCount() - 1));
        listView.setLayoutParams(params);
    }

}
