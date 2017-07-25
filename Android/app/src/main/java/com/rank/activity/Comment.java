package com.rank.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;

import com.rank.Adapter.ListviewCommentAdapter;
import com.rank.R;
import com.rank.interfaces.DrawableClickListener;
import com.rank.interfaces.WebApiResult;
import com.rank.models.CommentDetails;
import com.rank.networks.CallWebService;
import com.rank.networks.ConnectionDetector;
import com.rank.sharedPreference.SharedPreferencesManger;
import com.rank.utils.CommonUtils;
import com.rank.utils.Constants;
import com.rank.utils.JSONUtils;
import com.rank.utils.Urls;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class Comment extends AppCompatActivity implements WebApiResult {

    ListView listview;
    ImageView ivBack;
    Context mContext;
    String postId, userId;
    ArrayList<CommentDetails> commentList;
    ListviewCommentAdapter listview_adapter;
    CallWebService webService;
    EditText etComment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_comment);

        mContext = Comment.this;
        postId = getIntent().getStringExtra("postId");
        userId = SharedPreferencesManger.getPrefValue(mContext, Constants.USERID, SharedPreferencesManger.PREF_DATA_TYPE.STRING).toString();


        ivBack = (ImageView) findViewById(R.id.iv_back);
        etComment = (EditText) findViewById(R.id.etComment);

        listview = (ListView) findViewById(R.id.listview_comment);

        showCommentApi();

        setDrawableOnClickListner();

    }

    void setDrawableOnClickListner() {

        etComment.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                final int DRAWABLE_LEFT = 0;
                final int DRAWABLE_TOP = 1;
                final int DRAWABLE_RIGHT = 2;
                final int DRAWABLE_BOTTOM = 3;

                if (event.getAction() == MotionEvent.ACTION_UP) {
                    if (event.getRawX() >= (etComment.getRight() - etComment.getCompoundDrawables()[DRAWABLE_RIGHT].getBounds().width())) {

                        postCommentApi();
                        return true;
                    }
                }
                return false;
            }
        });
    }

    public void onClick(View view) {
        finish();
    }

    public static void setListViewHeightBasedOnChildren(ListView listView) {
        ListviewCommentAdapter listview_adapter = (ListviewCommentAdapter) listView.getAdapter();
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

    private void showCommentApi() {

        try {
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {
                webService = new CallWebService(mContext, Urls.showCommentUrl(postId), null, Constants.SERVICE_TYPE.SHOW_COMMENT, this);
                webService.execute();
            } else {
                CommonUtils.showToast(mContext, "Please connect with internet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void postCommentApi() {

        try {
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {
                webService = new CallWebService(mContext, Urls.postCommentUrl(etComment.getText().toString().trim(), userId, postId), null, Constants.SERVICE_TYPE.SEND_COMMENT, this);
                webService.execute();
            } else {
                CommonUtils.showToast(mContext, "Please connect with internet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void getWebResult(Constants.SERVICE_TYPE type, String result) {
        switch (type) {
            case SHOW_COMMENT:
                if (result != null) {
                    try {
                        System.out.println("Result: " + result);
//                        JSONObject jsonObject = new JSONObject(result);
                        JSONArray jsonArray = new JSONArray(result);
                        CommentDetails model;
                        commentList = new ArrayList<>();
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject commentListObj = jsonArray.getJSONObject(i);
                            model = new CommentDetails();
                            model.setId(JSONUtils.getIntFromJSON(commentListObj, "id"));
                            model.setPostId(JSONUtils.getIntFromJSON(commentListObj, "post_id"));
                            model.setComment(JSONUtils.getStringFromJSON(commentListObj, "comment"));
                            model.setUserId(JSONUtils.getIntFromJSON(commentListObj, "user_id"));
                            model.setCreatedAt(JSONUtils.getStringFromJSON(commentListObj, "created_at"));
                            model.setUpdatedAt(JSONUtils.getStringFromJSON(commentListObj, "updated_at"));
                            model.setDeletedAt(JSONUtils.getStringFromJSON(commentListObj, "deleted_at"));

                            commentList.add(model);
                        }
                        listview_adapter = new ListviewCommentAdapter(getApplicationContext(), commentList);
                        listview.setAdapter(listview_adapter);
                        setListViewHeightBasedOnChildren(listview);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                break;
            case SEND_COMMENT:
                if (result != null) {
                    try {
                        System.out.println("Result: " + result);
                        JSONObject jsonObject = new JSONObject(result);
                        etComment.setText("");

                        Intent intent = getIntent();
                        finish();
                        startActivity(intent);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                break;
        }
    }


}
