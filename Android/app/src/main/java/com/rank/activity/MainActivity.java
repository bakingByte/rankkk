package com.rank.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;

import com.rank.Adapter.HorizontalAdapter;
import com.rank.Adapter.Listview_Adapter;
import com.rank.Adapter.ViewPagerAdapter;
import com.rank.R;
import com.rank.helper.VerticalSpaceItemDecoration;
import com.rank.interfaces.WebApiResult;
import com.rank.models.UserPostDetails;
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
import java.util.List;

import static com.rank.R.id.horizontal_recycler_view1;


public class MainActivity extends AppCompatActivity implements View.OnClickListener, WebApiResult {


    Context mContext;
    CallWebService webService;
    ArrayList<UserPostDetails> userPostList;
    //ListView
    ListView listView;

    //ViewPager
    ViewPager pager;

    //ViewPagerAdapter
    public ViewPagerAdapter adapter;

    //Recycleview Integer
    int[] flag;

    private static final int VERTICAL_ITEM_SPACE = 25;

    //Imageview
    ImageView iv_globe;
    ImageView iv_chat;
    ImageView iv_location;
    ImageView iv_notification;
    ImageView iv_profile;

    //Recycleview
    private RecyclerView Horizontal_recycler_view1, horizontal_recycler_view;


    //Recyclerview Horzintal Adapter
    public HorizontalAdapter horizontalAdapter;


    List<Detail> detail;


    public static int FIRST_PAGE;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mContext = MainActivity.this;
        //Initiliase
        initiliase();


    }

    public int initiliase() {

        //Listview
        listView = (ListView) findViewById(R.id.listview);

        //ViewPager
        pager = (ViewPager) findViewById(R.id.myviewpager);


        //RecylerView
        horizontal_recycler_view = (RecyclerView) findViewById(R.id.horizontal_recycler_view);
        Horizontal_recycler_view1 = (RecyclerView) findViewById(horizontal_recycler_view1);

        //LinearLayout Manager
        LinearLayoutManager llm = new LinearLayoutManager(this);
        llm.setOrientation(LinearLayoutManager.HORIZONTAL);
        LinearLayoutManager llm1 = new LinearLayoutManager(this);
        llm1.setOrientation(LinearLayoutManager.HORIZONTAL);


        //RecylerView
        horizontal_recycler_view.setLayoutManager(llm);
        horizontal_recycler_view.addItemDecoration(new VerticalSpaceItemDecoration(VERTICAL_ITEM_SPACE));
        horizontal_recycler_view.setHasFixedSize(true);

        initializeData();

        showPostApi();

//
//        horizontal_recycler_view.setOnTouchListener(new View.OnTouchListener() {
//            @Override
//            public boolean onTouch(View view, MotionEvent motionEvent) {
//
//                ImageView imageView = (ImageView) view.findViewById(R.id.iv_share1);
//                imageView.setOnClickListener(new View.OnClickListener() {
//                    @Override
//                    public void onClick(View view) {
//                        Intent i = new Intent(MainActivity.this, Comment.class);
//                        startActivity(i);
//                    }
//                });
//                return false;
//            }
//        });

//        Horizontal_recycler_view1.setOnTouchListener(new View.OnTouchListener() {
//            @Override
//            public boolean onTouch(View view, MotionEvent motionEvent) {
//
//                ImageView imageView = (ImageView) view.findViewById(R.id.iv_share1);
//                imageView.setOnClickListener(new View.OnClickListener() {
//                    @Override
//                    public void onClick(View view) {
//                        Intent i = new Intent(MainActivity.this, Comment.class);
//                        startActivity(i);
//                    }
//                });
//                return false;
//            }
//        });


        //setListview Adapter
        Listview_Adapter listview_adapter = new Listview_Adapter(getApplicationContext()) {
            @Override
            protected void onCancelClick(View v, String s) {

            }
        };
        listView.setAdapter(listview_adapter);
        setListViewHeightBasedOnChildren(listView);


        flag = new int[]{R.drawable.user3, R.drawable.user4,
                R.drawable.user5, R.drawable.user6,
                R.drawable.user3, R.drawable.user4,
                R.drawable.user5, R.drawable.user6,
        };

        //Viewpageradapter
        adapter = new ViewPagerAdapter(MainActivity.this, flag);
        pager.setAdapter(adapter);
        pager.setOffscreenPageLimit(3);
        pager.setClipToPadding(false);
        //  pager.setPadding(20, 0, 20, 0);

        pager.setCurrentItem(FIRST_PAGE);


        //Imageview
        iv_globe = (ImageView) findViewById(R.id.iv_globe);
        iv_location = (ImageView) findViewById(R.id.iv_location);
        iv_notification = (ImageView) findViewById(R.id.iv_file);
        iv_profile = (ImageView) findViewById(R.id.iv_human);

        //setOnClicklIstener
        iv_globe.setOnClickListener(this);
        iv_location.setOnClickListener(this);
        iv_notification.setOnClickListener(this);
        iv_profile.setOnClickListener(this);


        return 0;

    }


    public void initializeData() {
        detail = new ArrayList<>();
        detail.add(new Detail("Nitin Peter", "Today in MenloPark,CA", "240", "27", R.drawable.notification3, R.drawable.image2, R.drawable.like1, R.drawable.unlike, R.drawable.share, R.drawable.comment));
        detail.add(new Detail("Nitin Peter", "Today in MenloPark,CA", "240", "27", R.drawable.notification3, R.drawable.image2, R.drawable.like1, R.drawable.unlike, R.drawable.share, R.drawable.comment));
        detail.add(new Detail("Nitin Peter", "Today in MenloPark,CA", "240", "27", R.drawable.notification3, R.drawable.image2, R.drawable.like1, R.drawable.unlike, R.drawable.share, R.drawable.comment));
        detail.add(new Detail("Nitin Peter", "Today in MenloPark,CA", "240", "27", R.drawable.notification3, R.drawable.image2, R.drawable.like1, R.drawable.unlike, R.drawable.share, R.drawable.comment));

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
        switch (view.getId()) {


            case R.id.iv_location:
                Intent location = new Intent(this, Communities.class);
                startActivity(location);
                break;
            case R.id.iv_file:
                Intent notification = new Intent(this, Notifications.class);
                startActivity(notification);
                break;
            case R.id.iv_human:
                Intent profile = new Intent(this, Profile.class);
                startActivity(profile);
                break;

        }

    }


    private void showPostApi() {
        try {
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {

                webService = new CallWebService(mContext, Urls.tripPost, null, Constants.SERVICE_TYPE.SHOW_POST, this, true);
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
            case SHOW_POST:
                if (result != null) {
                    try {
                        System.out.println("Result: " + result);
                        JSONObject jsonObject = new JSONObject(result);
                        JSONArray jsonArray = jsonObject.getJSONArray("post_data");
                        UserPostDetails model;

                        userPostList = new ArrayList<>();

                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject restaurantListObj = jsonArray.getJSONObject(i);
                            model = new UserPostDetails();
                            model.setId(JSONUtils.getIntFromJSON(restaurantListObj, "id"));
                            model.setDiscription(JSONUtils.getStringFromJSON(restaurantListObj, "discription"));
                            model.setComment(JSONUtils.getStringFromJSON(restaurantListObj, "comment"));
                            model.setLike(JSONUtils.getStringFromJSON(restaurantListObj, "like"));
                            model.setDislike(JSONUtils.getStringFromJSON(restaurantListObj, "dislike"));
                            model.setCreatedAt(JSONUtils.getStringFromJSON(restaurantListObj, "created_at"));
                            model.setUpdatedAt(JSONUtils.getStringFromJSON(restaurantListObj, "updated_at"));
                            model.setDeletedAt(JSONUtils.getStringFromJSON(restaurantListObj, "deleted_at"));
                            model.setTitle(JSONUtils.getStringFromJSON(restaurantListObj, "title"));
                            model.setPhoto(JSONUtils.getStringFromJSON(restaurantListObj, "photo"));
                            model.setPostImage(R.drawable.image2);
                            model.setUserNameId(JSONUtils.getIntFromJSON(restaurantListObj, "user_name_id"));

                            userPostList.add(model);

                        }

                        horizontalAdapter = new HorizontalAdapter(userPostList);
                        horizontal_recycler_view.setAdapter(horizontalAdapter);
//                        Horizontal_recycler_view1.setAdapter(horizontalAdapter);


                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
        }
    }
}
