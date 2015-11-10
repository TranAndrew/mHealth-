package com.example.inazakat.fallpredictionapp;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by inazakat on 9/23/2015.
 */
public class DatabaseHelper extends SQLiteOpenHelper {

    /*Declaring Variable for Database And Assigning Name*/
    public static final String DATABASE_NAME = "FallPrediction.db";
    public static final String TABLE_NAME = "GaitData_Table";
    public static final String COL_1 = "ID";
    public static final String COL_2 = "X_DATA";
    public static final String COL_3 = "Y_DATA";
    public static final String COL_4 = "Z_DATA";

    public DatabaseHelper(Context context) {
        /* DatabaseHelper Class Constructor Calling the Super Class Constructor to create Database */
        super(context, DATABASE_NAME, null, 1);
        SQLiteDatabase db = this.getWritableDatabase();
}

    @Override
    public void onCreate(SQLiteDatabase db) {

        /*This Method will Create the GaitData_Table in the Database*/
        db.execSQL("CREATE TABLE " + TABLE_NAME + "(ID integer PRIMARY KEY AUTOINCREMENT, X_DATA FLOAT, Y_DATA FLOAT, Z_DATA FLOAT)");

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
         /*This Method will Drop the GaitData_Table in the Database if its already exits*/
        db.execSQL("DROP TABLE IF EXISTS "+ TABLE_NAME);
        onCreate(db);
    }

    public double checkFallData(double x,double y,double z)
    {

       double g;
        int status=0;

        g = java.lang.Math.sqrt((x*x)+(y*y)+(z*z));


       /* SQLiteDatabase db = this.getWritableDatabase();
        String sql;



        sql = "select * from GaitData_Table where X_DATA = "+ x +" and Y_DATA = "+ y +" and Z_DATA = "+ z +"";
        Cursor recordset = db.rawQuery(sql,null);

        if (recordset.getCount()==0)
        {

            return 0;
        }
        else
            return 1;*/

       return g;

    }
    public void insertAccelerometerData(float x,float y,float z)
    {
        SQLiteDatabase db = this.getWritableDatabase();
        String isql;
        isql = "Insert into GaitData_Table (X_DATA,Y_DATA,Z_DATA) VALUES("+ x +","+ y +","+ z +")";
        db.execSQL(isql);


    }

}
