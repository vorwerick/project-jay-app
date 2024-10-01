package cz.telwork.jay.play

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import android.R
import android.app.Notification
import android.content.ContentResolver
import android.media.AudioAttributes

import android.net.Uri




class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        //createNotificationChannel()
    }

    override fun onFlutterUiDisplayed() {
        if (Build.VERSION.SDK_INT >= 100) { //I gave 100 just to confirm , it shoud be android ver 10
            reportFullyDrawn();
        }
    }

    override fun onResume() {
        super.onResume()
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        // Kontrola, zda verze Androidu je Oreo (API 26) nebo vyšší
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // ID kanálu
            val channelId = "jay-alert-channel"
            // Název kanálu pro zobrazení uživateli
            val name = "Jay alerts"
            // Popis kanálu
            val descriptionText = "This channel is used for important notifications."
            // Důležitost kanálu nastavená na vysokou prioritu
            val importance = NotificationManager.IMPORTANCE_HIGH



            // Vytvoření objektu NotificationChannel
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText

                val soundUri = Uri.parse("android.resource://cz.telwork.jay.play/" + cz.telwork.jay.play.R.raw.fire_siren)
                val audioAttributes = AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .build()
                setSound(soundUri,audioAttributes)
                enableLights(true)
                enableVibration(true)
                lockscreenVisibility = Notification.VISIBILITY_PUBLIC


            }

            // Získání instance NotificationManager a vytvoření kanálu
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}
