package it.angelocassano.flutter_nexi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import it.angelocassano.flutter_nexi.services.payment.PaymentApi
import it.angelocassano.flutter_nexi.services.payment.PaymentServiceImpl

/** FlutterNexiPlugin */
class FlutterNexiPlugin : FlutterPlugin, ActivityAware {
    private var paymentService: PaymentServiceImpl? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        paymentService = PaymentServiceImpl()
        PaymentApi.setUp(binding.binaryMessenger, paymentService)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        paymentService = null
        PaymentApi.setUp(binding.binaryMessenger, paymentService)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        paymentService?.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}
