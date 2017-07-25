package com.rank.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.rank.R;
import com.rank.interfaces.WebApiResult;
import com.rank.networks.CallWebService;
import com.rank.networks.ConnectionDetector;
import com.rank.sharedPreference.SharedPreferencesManger;
import com.rank.utils.CommonUtils;
import com.rank.utils.Constants;
import com.rank.utils.JSONUtils;
import com.rank.utils.Urls;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Hashtable;

public class Login extends AppCompatActivity implements View.OnClickListener, WebApiResult {

    Context mContext;
    //RelativeLayout
    RelativeLayout rl_forgotPassword;
    RelativeLayout rl_signUp;

    //Textview
    TextView tv_login;

    EditText etUsername, etPassword;
    CallWebService webService;
    String userId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mContext = Login.this;
//        userId = SharedPreferencesManger.getPrefValue(mContext, Constants.USERID, SharedPreferencesManger.PREF_DATA_TYPE.STRING).toString();
//        if (!userId.isEmpty()) {
//            Intent intent = new Intent(this, MainActivity.class);
//            startActivity(intent);
//
//        }
        setContentView(R.layout.activity_login);

        //initialization
        initialization();


        //setClickListener
        setClickListener();
    }

    //initialization
    public void initialization() {

        //RelativeLayout
        rl_forgotPassword = (RelativeLayout) findViewById(R.id.rl_forgotPassword);
        rl_signUp = (RelativeLayout) findViewById(R.id.rl_signUp);

        //Textview
        tv_login = (TextView) findViewById(R.id.tv_login);

        //edittext
        etUsername = (EditText) findViewById(R.id.etUsername);
        etPassword = (EditText) findViewById(R.id.etPassword);

    }

    //setClickListener
    public void setClickListener() {

        //RelativeLayout
        rl_forgotPassword.setOnClickListener(this);
        rl_signUp.setOnClickListener(this);

        //Textview
        tv_login.setOnClickListener(this);
    }

    private void loginApi() {
        try {
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {

                webService = new CallWebService(mContext, Urls.loginUrl(CommonUtils.convertUTF(etUsername.getText().toString().trim()), CommonUtils.convertUTF(etPassword.getText().toString().trim())), null, Constants.SERVICE_TYPE.LOGIN, this, true);
                webService.execute();
            } else {
                CommonUtils.showToast(mContext, "Please connect with internet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onClick(View v) {

        switch (v.getId()) {

            case R.id.rl_forgotPassword:
                Intent rl_forgotPassword = new Intent(this, ForgotPassword.class);
                startActivity(rl_forgotPassword);
                break;

            case R.id.rl_signUp:
                Intent rl_signUp = new Intent(this, SignUp.class);
                startActivity(rl_signUp);
                break;

            case R.id.tv_login:

                CommonUtils.hideKeyboard(mContext);

                if (validateLoginForm()) {
                    if (new ConnectionDetector(mContext).isConnectingToInternet()) {
                        loginApi();
                    } else {
                        CommonUtils.showAlertDialog(mContext, mContext.getResources().getString(R.string.no_network_connection), mContext.getResources().getString(R.string.check_connection));
                    }
                }
                break;
        }
    }

    //validation
    private boolean validateLoginForm() {
        if (etUsername.getText().toString().trim().isEmpty()) {
            CommonUtils.showToast(mContext, getResources().getString(R.string.txt_empty_username));
            return false;
        }
        if (etPassword.getText().toString().trim().isEmpty()) {
            CommonUtils.showToast(mContext, mContext.getResources().getString(R.string.txt_empty_password));
            return false;
        }
        return true;
    }

    @Override
    public void getWebResult(Constants.SERVICE_TYPE type, String result) {
        switch (type) {
            case LOGIN:
                if (result != null) {
                    try {
                        System.out.println("Result: " + result);
                        JSONObject jsonObject = new JSONObject(result);
                        boolean success = JSONUtils.getBooleanFromJSON(jsonObject, "success");
                        if (success == true) {
                            JSONArray jsonArray = jsonObject.getJSONArray("user");
                            JSONObject userData = jsonArray.getJSONObject(0);

                            SharedPreferencesManger.setPrefValue(mContext, Constants.EMAILID, JSONUtils.getStringFromJSON(userData, "email"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.USERID, JSONUtils.getStringFromJSON(userData, "id"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.NAME, JSONUtils.getStringFromJSON(userData, "name"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.ROLEID, JSONUtils.getStringFromJSON(userData, "role_id"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.REMEMBER_TOKEN, JSONUtils.getStringFromJSON(userData, "remember_token"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.CREATED_AT, JSONUtils.getStringFromJSON(userData, "created_at"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.UPDATED_AT, JSONUtils.getStringFromJSON(userData, "updated_at"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.DELETED_AT, JSONUtils.getStringFromJSON(userData, "deleted_at"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.IMAGES, JSONUtils.getStringFromJSON(userData, "pic"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);
                            SharedPreferencesManger.setPrefValue(mContext, Constants.PLACE, JSONUtils.getStringFromJSON(userData, "place"), SharedPreferencesManger.PREF_DATA_TYPE.STRING);

                            Intent intent = new Intent(this, MainActivity.class);
                            startActivity(intent);

                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
        }
    }
}
