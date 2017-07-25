package com.rank.Adapter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.rank.activity.Comment;
import com.rank.activity.Detail;
import com.rank.activity.Post;
import com.rank.R;
import com.rank.interfaces.WebApiResult;
import com.rank.models.UserPostDetails;
import com.rank.networks.CallWebService;
import com.rank.networks.ConnectionDetector;
import com.rank.sharedPreference.SharedPreferencesManger;
import com.rank.utils.CommonUtils;
import com.rank.utils.Constants;
import com.rank.utils.Urls;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import static android.support.v7.widget.RecyclerView.ViewHolder;
import static android.view.ViewGroup.getChildMeasureSpec;

/**
 * Created by ankita-pc on 4/7/17.
 */

public class HorizontalAdapter extends RecyclerView.Adapter<HorizontalAdapter.MyViewHolder> implements WebApiResult {


    // private List<String> horizontalList;
    ArrayList<UserPostDetails> list = new ArrayList<>();
    Context mContext;
    UserPostDetails model;
    String userId;

   /* public HorizontalAdapter(List<Detail> list) {
        this.list = list;
    }*/

    public HorizontalAdapter(ArrayList<UserPostDetails> list) {
        this.list = list;
    }

    @Override
    public void getWebResult(Constants.SERVICE_TYPE type, String result) {
        switch (type) {
            case LIKEORDISLIKE:
                if (result != null) {
                    try {

//                        Intent intent = getIntent();
//                        mContext.finish();
//                        mContext.startActivity(intent);

//                        System.out.println("Result: " + result);
//                        JSONObject jsonObject = new JSONObject(result);
                        notifyDataSetChanged();

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    CommonUtils.showToast(mContext, "No record found");
                }
                break;

        }
    }


    public class MyViewHolder extends ViewHolder implements View.OnClickListener {

        public TextView tv_user, tv_address, tv_like, tv_like1, tv_unlike, tv_unlike1;
        public ImageView iv_user, iv_display, iv_display1, iv_like, iv_like1, iv_unlike, iv_unlike1, iv_share, iv_share1, iv_comment, iv_comment1;
        public RelativeLayout rlHeader, rlFooter, rlFooter1, relativeLayout;
        Detail Detail;

        RelativeLayout.LayoutParams parms;

        public MyViewHolder(View view) {
            super(view);


            //RelativeLayout
            rlHeader = (RelativeLayout) view.findViewById(R.id.rl_header);
            relativeLayout = (RelativeLayout) view.findViewById(R.id.relativelayout);
            rlFooter = (RelativeLayout) view.findViewById(R.id.rl_footer2);
            rlFooter1 = (RelativeLayout) view.findViewById(R.id.rl_footer1);

            //Textview
            tv_user = (TextView) view.findViewById(R.id.tv_user1);
            tv_address = (TextView) view.findViewById(R.id.tv_address1);
            tv_like = (TextView) view.findViewById(R.id.tv_like1);
//            tv_like1 = (TextView) view.findViewById(R.id.tv_like2);
            tv_unlike = (TextView) view.findViewById(R.id.tv_unlike1);
//            tv_unlike1 = (TextView) view.findViewById(R.id.tv_unlike2);


            //Imageview
            iv_user = (ImageView) view.findViewById(R.id.iv_user1);
            iv_display = (ImageView) view.findViewById(R.id.image1);
//            iv_display1 = (ImageView) view.findViewById(R.id.image2);
            iv_like = (ImageView) view.findViewById(R.id.iv_like1);
//            iv_like1 = (ImageView) view.findViewById(R.id.iv_like2);
            iv_unlike = (ImageView) view.findViewById(R.id.iv_unlike1);
//            iv_unlike1 = (ImageView) view.findViewById(R.id.iv_unlike2);
            iv_share = (ImageView) view.findViewById(R.id.iv_share1);
//            iv_share1 = (ImageView) view.findViewById(R.id.iv_share2);
            iv_comment = (ImageView) view.findViewById(R.id.iv_comment1);
//            iv_comment1 = (ImageView) view.findViewById(R.id.iv_comment2);

            mContext = view.getContext();

//            relativeLayout.setOnClickListener(this);

        }


        @Override
        public void onClick(View view) {
            final Intent intent;
            intent = new Intent(mContext, Post.class);
            mContext.startActivity(intent);

        }
    }


    private void likeDislikeApi(String likeDislike, String postId) {
        try {
            userId = SharedPreferencesManger.getPrefValue(mContext, Constants.USERID, SharedPreferencesManger.PREF_DATA_TYPE.STRING).toString();
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {
                CallWebService webService = new CallWebService(mContext, Urls.likeDislikeUrl(likeDislike, postId, userId), null, Constants.SERVICE_TYPE.LIKEORDISLIKE, this);
                webService.execute();
            } else {
                CommonUtils.showToast(mContext, "Please connect with internet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recyclerview_mainactivity, parent, false);


        return new MyViewHolder(itemView);
        //return null;
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, final int position) {

        model = list.get(position);
        holder.tv_user.setText(model.getTitle());
        holder.tv_address.setText(model.getTitle());
        holder.tv_like.setText(model.getLike());
//        holder.tv_like1.setText(model.getLike());
        holder.tv_unlike.setText(model.getDislike());
//        holder.tv_unlike1.setText(model.getDislike());

//        holder.iv_user.setImageResource(Integer.parseInt(String.valueOf(model.getUser_id())));
        holder.iv_display.setImageResource(model.getPostImage());
//        holder.iv_display1.setImageResource(Integer.parseInt(String.valueOf(model.getUser_display())));
//        holder.iv_like.setImageResource(Integer.parseInt(String.valueOf(model.getUser_like())));
//        holder.iv_like1.setImageResource(Integer.parseInt(String.valueOf(model.getUser_like())));
//        holder.iv_unlike.setImageResource(Integer.parseInt(String.valueOf(model.getUser_unlike())));
//        holder.iv_unlike1.setImageResource(Integer.parseInt(String.valueOf(model.getUser_unlike())));
//        holder.iv_share.setImageResource(Integer.parseInt(String.valueOf(model.getUser_share())));
//        holder.iv_share1.setImageResource(Integer.parseInt(String.valueOf(model.getUser_share())));
//        holder.iv_comment.setImageResource(Integer.parseInt(String.valueOf(model.getUser_comment())));
//        holder.iv_comment1.setImageResource(Integer.parseInt(String.valueOf(model.getUser_comment())));

        holder.iv_display.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final Intent intent;
                intent = new Intent(mContext, Post.class);
                mContext.startActivity(intent);
            }
        });

        holder.iv_like.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                likeDislikeApi("like", String.valueOf(list.get(position).getId()));

//                final Intent intent;
//                intent = new Intent(mContext, Comment.class);
//                mContext.startActivity(intent);
            }
        });
        holder.iv_unlike.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                likeDislikeApi("like", String.valueOf(list.get(position).getId()));

//                final Intent intent;
//                intent = new Intent(mContext, Comment.class);
//                mContext.startActivity(intent);
            }
        });

        holder.iv_comment.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final Intent intent;
                intent = new Intent(mContext, Comment.class);
                intent.putExtra("postId", String.valueOf(list.get(position).getId()));
                mContext.startActivity(intent);
            }
        });

//        holder.iv_comment1.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                final Intent intent;
//                intent = new Intent(mContext, Comment.class);
//                mContext.startActivity(intent);
//            }
//        });

//        if (position == 0) {
//            holder.rlHeader.setVisibility(View.VISIBLE);
//            holder.rlFooter1.setVisibility(View.GONE);
//            holder.rlFooter.setVisibility(View.VISIBLE);
//
//        } else {
//            holder.rlHeader.setVisibility(View.GONE);
//            holder.iv_display.setVisibility(View.GONE);
//            holder.iv_display1.setVisibility(View.VISIBLE);
//            holder.rlFooter1.setVisibility(View.VISIBLE);
//            holder.rlFooter.setVisibility(View.GONE);
//        }
    }


    @Override
    public void onAttachedToRecyclerView(RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);
    }

    @Override
    public int getItemCount() {

        return list.size();
        //return 0;
    }


}
