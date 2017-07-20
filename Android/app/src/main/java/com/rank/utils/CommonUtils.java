package com.rank.utils;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.support.v4.app.ActivityCompat;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.TextView;

import com.rank.R;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.widget.Toast;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Pankaj
 */

public class CommonUtils {

    public static AlertDialog dialog, dialog2;
    static DisplayMetrics displaymetrics;
    public static Dialog customDialog;
    public static TextView messageTv, buttonTv;

    public static void showAlertDialog(Context mContext, String title, String message) {

        if (mContext == null) return;
        if (dialog != null && dialog.isShowing()) return;

        dialog = new AlertDialog.Builder(mContext).create();
        dialog.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
        if (Build.VERSION.SDK_INT >= 23) {
            dialog.getWindow().setType(WindowManager.LayoutParams.TYPE_TOAST);
        } else {
            dialog.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
        }
        dialog.setTitle(title);
        dialog.setMessage(message);
        dialog.setButton(AlertDialog.BUTTON_POSITIVE, mContext.getString(R.string.txt_ok), new OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    public static String firstCharacterCapital(String s) {
        return s.substring(0, 1).toUpperCase() + s.substring(1);
    }

    //validation

    public static void showAlertDialogWith2Btn(Context mContext, String title, String message) {

        if (mContext == null) return;
        if (dialog2 != null && dialog2.isShowing()) return;
        dialog2 = new AlertDialog.Builder(mContext).create();
        dialog2.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
        if (Build.VERSION.SDK_INT >= 23) {
            dialog2.getWindow().setType(WindowManager.LayoutParams.TYPE_TOAST);
        } else {
            dialog2.getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
        }
        dialog2.setTitle(title);
        dialog2.setMessage(message);
        dialog2.setButton(AlertDialog.BUTTON_POSITIVE, mContext.getString(R.string.txt_ok), new OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        dialog2.setButton(AlertDialog.BUTTON_NEGATIVE, mContext.getString(R.string.txt_cancel), new OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });

        dialog2.show();
    }



    public static void showToast(Context mContext, String message) {
        Toast toast = Toast.makeText(mContext, message, Toast.LENGTH_SHORT);
        toast.setGravity(Gravity.CENTER, 0, 0);
        toast.show();
    }


    public static boolean isValidEmailAddress(String emailAddress) {
        String emailRegEx;
        Pattern pattern;
        // Regex for a valid email address
        emailRegEx = "^[A-Za-z0-9._%+\\-]+@[A-Za-z0-9.\\-]+\\.[A-Za-z]{2,4}$";
        // Compare the regex with the email address
        pattern = Pattern.compile(emailRegEx);
        Matcher matcher = pattern.matcher(emailAddress);
        if (!matcher.find()) {
            return false;
        }
        return true;
    }

    public static boolean checkPassWordAndConfirmPassword(String password, String confirmPassword) {
        boolean pstatus = false;
        if (confirmPassword != null && password != null) {
            if (password.equals(confirmPassword)) {
                pstatus = true;
            }
        }
        return pstatus;
    }

    public static void hideKeyboard(Context ctx) {
        InputMethodManager inputManager = (InputMethodManager) ctx
                .getSystemService(Context.INPUT_METHOD_SERVICE);

        // check if no view has focus:
        View v = ((Activity) ctx).getCurrentFocus();
        if (v == null)
            return;

        inputManager.hideSoftInputFromWindow(v.getWindowToken(), 0);
    }

    public static String checkStringValue(String value) {

        if (value == null || value.equals(null) || value.equals("null") || value.equals(""))
            value = "";
        return value;
    }

    /**
     * convertUTF method used to encode string into UTF-8
     *
     * @param s
     * @return
     */
    public static String convertUTF(String s) {
        String data = "";
        try {
            data = URLEncoder.encode(s, "UTF-8");
            if (data.contains("%5C")) {
                data = data.replaceAll("%5C", "\\\\");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }


    public static boolean isAppInForeground(Context context) {
        List<ActivityManager.RunningTaskInfo> tasks =
                ((ActivityManager) context.getSystemService(
                        Context.ACTIVITY_SERVICE))
                        .getRunningTasks(1);
        if (tasks.isEmpty()) {
            return false;
        }
        return tasks
                .get(0)
                .topActivity
                .getPackageName()
                .equalsIgnoreCase(context.getPackageName());
    }

    public static String getCalculatedDate(String dateFormat, int days) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat s = new SimpleDateFormat(dateFormat);
        cal.add(Calendar.DAY_OF_YEAR, days);
        return s.format(new Date(cal.getTimeInMillis()));
    }

    public static boolean hasPermissions(Context context, String... permissions) {
        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }

    /*   private boolean isValidMobile(String phone2)
       {
           boolean check=false;
           if(!Pattern.matches("[a-zA-Z]+", text))
           {
               if(phone2.length() < 6 || phone2.length() > 13)
               {
                   check = false;
                   txtPhone.setError("Not Valid Number");
               }
               else
               {
                   check = true;
               }
           }
           else
           {
               check=false;
           }
           return check;
       }
   */
    public static boolean isValidMobile(String phone) {
        return android.util.Patterns.PHONE.matcher(phone).matches();
    }

}
