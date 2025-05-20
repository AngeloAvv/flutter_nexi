package it.angelocassano.flutter_nexi.services.payment

import android.app.Activity
import it.nexi.xpay.CallBacks.FrontOfficeCallbackQP
import it.nexi.xpay.Models.WebApi.Errors.ApiErrorResponse
import it.nexi.xpay.Models.WebApi.Requests.FrontOffice.ApiFrontOfficeQPRequest
import it.nexi.xpay.Models.WebApi.Responses.FrontOffice.ApiFrontOfficeQPResponse
import it.nexi.xpay.Utils.EnvironmentUtils
import it.nexi.xpay.XPay

class PaymentServiceImpl : PaymentApi {

    var activity: Activity? = null

    override fun pay(request: PaymentRequest, callback: (Result<PaymentResult>) -> Unit) {
        val activity = this.activity
        if (activity == null) {
            callback(Result.failure(IllegalStateException("Activity is null")))
            return
        }

        try {
            val xPay = XPay(activity, request.secretKey)

            xPay.FrontOffice.setEnvironment(
                if (request.environment == Environment.PRODUCTION)
                    EnvironmentUtils.Environment.PROD
                else
                    EnvironmentUtils.Environment.TEST
            )

            request.domain?.takeIf { it.isNotBlank() }?.let {
                xPay.FrontOffice.setDomain(it)
            }

            val xPayRequest = ApiFrontOfficeQPRequest(
                request.alias,
                request.codTrans,
                request.currency,
                request.amount
            )

            xPay.FrontOffice.paga(xPayRequest, true, object : FrontOfficeCallbackQP {

                override fun onConfirm(response: ApiFrontOfficeQPResponse) {
                    if (response.isValid) {
                        callback(Result.success(PaymentResult.COMPLETED))
                    } else {
                        val message = response.error?.message ?: "Unknown payment error"
                        callback(Result.failure(RuntimeException(message)))
                    }
                }

                override fun onCancel(response: ApiFrontOfficeQPResponse) {
                    callback(Result.success(PaymentResult.CANCELED))
                }

                override fun onError(error: ApiErrorResponse) {
                    callback(Result.failure(RuntimeException(error.error.message)))
                }
            })

        } catch (e: Exception) {
            callback(Result.failure(e))
        }
    }
}
