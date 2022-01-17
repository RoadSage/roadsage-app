package io.unitic.roadsage

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "siri_suggestions"
    private val CHANNEL_ANDROID = "io.unitic.roadsage/google_assistant"
    private val TAG = "RoadSageMainActivity"
    private var assistantQuery: String? = null;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        logIntent(intent)
    }

    private fun logIntent(intent: Intent) {
        if (intent.action != null) {
            Log.d(TAG, "Got intent");
            Log.d(TAG, intent.action!!);
        }

        val bundle: Bundle = intent.extras ?: return

        Log.d(TAG, "======= logIntent ========= %s")
        Log.d(TAG, "Logging intent data start")

        bundle.keySet().forEach { key ->
            Log.d(TAG, "[$key=${bundle.get(key)}]");
        }

        // TODO: refactor this
        if (bundle.keySet().contains("articleBody")) {
            Log.d(TAG, "Setting query..")
            assistantQuery = bundle.get("articleBody").toString()
            if (assistantQuery != null) {
                Log.d(TAG, assistantQuery!!)
            }
        }

        Log.d(TAG, "Logging intent data complete")
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Android method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ANDROID).setMethodCallHandler {
            call, result ->
            if (call.method!!.contentEquals("getAssistantQuery")) {
                result.success(assistantQuery);
                assistantQuery = null;
            }
        }

        // No-op for the iOS method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call, result -> }
    }
}
