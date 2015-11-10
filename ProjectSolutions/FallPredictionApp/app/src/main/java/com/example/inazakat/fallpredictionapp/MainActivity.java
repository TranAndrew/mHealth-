package com.example.inazakat.fallpredictionapp;

import android.app.AlertDialog;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements SensorEventListener {
    DatabaseHelper myDb;

    Sensor accelerometer;
    SensorManager sm;
    TextView acceleration;
    TextView label;





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myDb = new DatabaseHelper(this);

        sm = (SensorManager) getSystemService((SENSOR_SERVICE));
        accelerometer = (sm).getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        sm.registerListener(this, accelerometer,SensorManager.SENSOR_DELAY_NORMAL);
        acceleration = (TextView)findViewById(R.id.accelaration);
        label = (TextView)findViewById(R.id. label);



    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onSensorChanged(SensorEvent event) {


        //myDb.insertAccelerometerData(event.values[0],event.values[1],event.values[2]);


        double status;


        status = myDb.checkFallData(event.values[0],event.values[1],event.values[2]);
        //status = myDb.checkFallData(1,2,3);
        //acceleration.setText("Accelerometer X: "+event.values[0]+"\nAccelerometer  Y: "+event.values[1]+"\nAccelerometer Z: "+event.values[2]);

        acceleration.setText("Accelerometer X: "+event.values[0]+"\nAccelerometer  Y: "+event.values[1]+"\nAccelerometer Z: "+event.values[2]);

       // label.setText(Double.toString(status));

        if (status>=10.00)
        {

            //label.setText(Double.toString(status));

            label.setText("fall");
            setContentView(R.layout.activity_notification);

        }
        else
        {

            label.setText("Normal");
            setContentView(R.layout.activity_main);

        }








    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
}
