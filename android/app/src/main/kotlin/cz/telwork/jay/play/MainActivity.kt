package cz.telwork.jay.play

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    private val CHANNEL = "recreateNotificationChannel"

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        //createNotificationChannel()


    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "createNotificationChannel") {
                removeNotificationChannel()
                createNotificationChannel()
                result.success(true);
            } else if (call.method == "dialNumber") {
                val hashMap = call.arguments as HashMap<*, *> //Get the arguments as a HashMap
                val number = hashMap["number"] //Get the ar
                val intent = Intent()
                intent.action = Intent.ACTION_DIAL // Action for what intent called for
                intent.data =
                    Uri.parse("tel: $number") // Data with intent respective action on intent
                startActivity(intent)

                result.success(true);
            } else {
                result.notImplemented()
            }
        }
    }

    @SuppressLint("NewApi")
    private fun removeNotificationChannel() {
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.getNotificationChannel("jay-alert-channel").apply {
            setSound(null, null)
            name = "old"
        }
        notificationManager.deleteNotificationChannel("jay-alert-channel");
    }

    override fun onFlutterUiDisplayed() {
        if (Build.VERSION.SDK_INT >= 100) { //I gave 100 just to confirm , it shoud be android ver 10
            reportFullyDrawn();
        }
    }

    override fun onResume() {
        super.onResume()
        removeNotificationChannel()
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        val sharedPref =
            context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                ?: return

        val sound = sharedPref.getString("flutter.notificationSound", "fire_siren")
        val resource = when (sound) {
            "bit" -> cz.telwork.jay.play.R.raw.bit
            "alarm" -> cz.telwork.jay.play.R.raw.alarm
            "siren" -> cz.telwork.jay.play.R.raw.siren
            "fire_siren" -> cz.telwork.jay.play.R.raw.fire_siren
            else -> 0
        }

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




            println(sound + " " + resource.toString())

            // Vytvoření objektu NotificationChannel
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText


                val soundUri =
                    Uri.parse("android.resource://cz.telwork.jay.play/$resource")
                val audioAttributes = AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .build()
                setSound(soundUri, audioAttributes)

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
