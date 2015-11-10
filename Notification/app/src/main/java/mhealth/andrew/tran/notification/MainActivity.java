package mhealth.andrew.tran.notification;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;


public class MainActivity extends AppCompatActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //Intent intent = getIntent();
        //String value = intent.getStringExtra("key");
        //Intent myIntent = new Intent(MainActivity.this, FallActivity.class);
        //myIntent.putExtra("key",value);
        //MainActivity.this.startActivity(myIntent);
    }

    @Override
    protected void onStart() {
        super.onStart();
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

    public void fallMessage(View view){
       Intent fallMessage= new Intent(MainActivity.this, FallActivity.class);
       MainActivity.this.startActivity(fallMessage);

    }
    public void notFallMessage(View view){
        Intent notFallMessage = new Intent(MainActivity.this, NotFall.class);
        MainActivity.this.startActivity(notFallMessage);
    }

}
