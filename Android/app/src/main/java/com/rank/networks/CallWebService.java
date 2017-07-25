package com.rank.networks;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;


import com.rank.R;
import com.rank.interfaces.WebApiResult;
import com.rank.utils.Constants;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Enumeration;
import java.util.Hashtable;

public class CallWebService extends AsyncTask<String, String, String> {
    String requestApi;
    Context mContext;
    boolean showProcessing;
    HttpURLConnection connection;
    Constants.SERVICE_TYPE mType;
    WebApiResult webServiceResult;
    Hashtable<String, String> postParameters;
    ProgressDialog prog;
    boolean value = true;


    public CallWebService(Context mContext, String url, Hashtable<String, String> parameters, Constants.SERVICE_TYPE type,
                          WebApiResult webResultInterface) {
        this.mContext = mContext;
        this.requestApi = url;
        this.mType = type;
        this.postParameters = parameters;
        this.webServiceResult = webResultInterface;
    }

    public CallWebService(Context mContext, String url, Hashtable<String, String> parameters, Constants.SERVICE_TYPE type,
                          WebApiResult webResultInterface, boolean value) {
        this.mContext = mContext;
        this.requestApi = url;
        this.mType = type;
        this.postParameters = parameters;
        this.webServiceResult = webResultInterface;
        this.value = value;//check progress bar status
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
        if (value) {
            prog = new ProgressDialog(mContext);
            prog.setMessage(mContext.getResources().getString(R.string.txt_loading));
            // prog.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
//            if (Build.VERSION.SDK_INT >= 23) {
//                prog.getWindow().setType(WindowManager.LayoutParams.TYPE_TOAST);
//            } else {
//                prog.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
//            }
            prog.setIndeterminate(false);
            prog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
            prog.setCancelable(false);
            prog.show();
        }

    }

    @Override
    protected String doInBackground(String... params) {
        try {
            URL url = new URL(this.requestApi);
            System.out.println("REQUEST : " + url);

            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("Accept-Charset", "UTF-8");

            connection.setConnectTimeout(30000);

           if(url.getQuery()!=null) {
               connection.setRequestMethod("POST");
               connection.setUseCaches(false);
               connection.setDoInput(true);
               connection.setDoOutput(true);

           } else
            connection.setRequestMethod("GET");



            //Send request
            if (postParameters != null) {
                DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream());
                outputStream.writeBytes(getPostParamString(postParameters));
                outputStream.flush();
                outputStream.close();
            }

            //Get Response
            InputStream inputStream = connection.getInputStream();


            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            String line;
            StringBuffer response = new StringBuffer();
            System.out.println("response: " + response.toString());
            while ((line = bufferedReader.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            bufferedReader.close();
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        return null;
    }

    /**
     * Pass Hashtable of key value pair we need to post
     *
     * @param params
     * @return
     */
    private String getPostParamString(Hashtable<String, String> params) {
        if (params.size() == 0)
            return "";
        StringBuffer buf = new StringBuffer();
        Enumeration<String> keys = params.keys();
        while (keys.hasMoreElements()) {
            buf.append(buf.length() == 0 ? "" : "&");
            String key = keys.nextElement();
            buf.append(key).append("=").append(params.get(key));
        }
        System.out.println(buf.toString());
        return buf.toString();
    }

    @Override
    protected void onPostExecute(String result) {
        super.onPostExecute(result);

        if (value) {
            if (prog.isShowing()) {
                prog.dismiss();
            }
        }
        if (!(result == null)) {
            webServiceResult.getWebResult(mType, result);
        }
    }

}