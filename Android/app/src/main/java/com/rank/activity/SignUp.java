package com.rank.activity;

import android.app.DatePickerDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.DatePicker;
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

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class SignUp extends AppCompatActivity implements View.OnClickListener, WebApiResult {

    //RelativeLayout
    RelativeLayout rl_back;
    EditText etDob, etFirstName, etLastName, etEmail, etPassword, etWhoAreYou;
    TextView tvSignUp;
    private SimpleDateFormat dateFormatter;
    private DatePickerDialog fromDatePickerDialog;

    private Context mContext;
    CallWebService webService;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        mContext = SignUp.this;
        //initialization
        initialization();

        //setClickListener
        setClickListener();
    }

    //initialization
    public void initialization() {

        //RelativeLayout
        rl_back = (RelativeLayout) findViewById(R.id.rl_back);

        //Edittext
        etFirstName = (EditText) findViewById(R.id.etFirstName);
        etLastName = (EditText) findViewById(R.id.etLastName);
        etEmail = (EditText) findViewById(R.id.etEmail);
        etPassword = (EditText) findViewById(R.id.etPassword);
        etWhoAreYou = (EditText) findViewById(R.id.etWhoAreYou);
        etDob = (EditText) findViewById(R.id.etDob);

        //textView
        tvSignUp = (TextView) findViewById(R.id.tvSignUp);

        dateFormatter = new SimpleDateFormat("dd MMMM yyyy", Locale.US);
        setDateTimeField();
    }


    private void setDateTimeField() {
        Calendar newCalendar = Calendar.getInstance();
        fromDatePickerDialog = new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {
            public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                Calendar newDate = Calendar.getInstance();
                newDate.set(year, monthOfYear, dayOfMonth);
                etDob.setText(dateFormatter.format(newDate.getTime()));
            }
        }, newCalendar.get(Calendar.YEAR), newCalendar.get(Calendar.MONTH), newCalendar.get(Calendar.DAY_OF_MONTH));
        fromDatePickerDialog.getDatePicker().setMaxDate(System.currentTimeMillis());
    }

    //setClickListener
    public void setClickListener() {

        //RelativeLayout
        rl_back.setOnClickListener(this);
        etDob.setOnClickListener(this);
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
            case R.id.etDob:
                fromDatePickerDialog.show();
                break;
            case R.id.tvSignUp:
                if (validateLoginForm()) {
                    if (new ConnectionDetector(mContext).isConnectingToInternet()) {

                        signUpApi();
                    } else {
                        CommonUtils.showAlertDialog(mContext, mContext.getResources().getString(R.string.no_network_connection), mContext.getResources().getString(R.string.check_connection));
                    }
                }
                break;
        }

    }

    private void signUpApi() {
        try {
            if (new ConnectionDetector(mContext).isConnectingToInternet()) {

                CommonUtils.convertUTF(etFirstName.getText().toString().trim());
                CommonUtils.convertUTF(etLastName.getText().toString().trim());
                CommonUtils.convertUTF(etEmail.getText().toString().trim());
                CommonUtils.convertUTF(etPassword.getText().toString().trim());
                CommonUtils.convertUTF(etDob.getText().toString().trim());
                CommonUtils.convertUTF(etWhoAreYou.getText().toString().trim());

                webService = new CallWebService(mContext, Urls.registerUrl("", ""), null, Constants.SERVICE_TYPE.SIGNUP, this, true);
                webService.execute();
            } else {
                CommonUtils.showToast(mContext, "Please connect with internet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //validation
    private boolean validateLoginForm() {
        if (etFirstName.getText().toString().trim().isEmpty()) {
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
            case SIGNUP:
                if (result != null) {

                }
        }
    }
}
