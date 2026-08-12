package com.yinxin.app

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.os.Handler
import android.os.Looper

class PrinterDiscovery(private val context: Context) {
    private var nsdManager: NsdManager? = null
    private var discoveryListener: NsdManager.DiscoveryListener? = null
    private val handler = Handler(Looper.getMainLooper())
    private val foundPrinters = mutableListOf<Map<String, String>>()
    private var callback: ((List<Map<String, String>>) -> Unit)? = null
    private var resolveCount = 0
    private val maxResolves = 20

    fun discover(onResult: (List<Map<String, String>>) -> Unit) {
        callback = onResult
        foundPrinters.clear()
        resolveCount = 0
        nsdManager = context.getSystemService(Context.NSD_SERVICE) as NsdManager

        discoveryListener = object : NsdManager.DiscoveryListener {
            override fun onDiscoveryStarted(regType: String) {}
            override fun onDiscoveryStopped(regType: String) {}
            override fun onStartDiscoveryFailed(serviceType: String, errorCode: Int) {
                stop()
                handler.post { callback?.invoke(emptyList()) }
            }
            override fun onStopDiscoveryFailed(serviceType: String, errorCode: Int) {}

            override fun onServiceFound(serviceInfo: NsdServiceInfo) {
                if (resolveCount >= maxResolves) return
                resolveCount++
                nsdManager?.resolveService(serviceInfo, object : NsdManager.ResolveListener {
                    override fun onResolveFailed(info: NsdServiceInfo, errorCode: Int) {}
                    override fun onServiceResolved(info: NsdServiceInfo) {
                        val printer = mapOf(
                            "name" to info.serviceName,
                            "host" to info.host?.hostAddress.orEmpty(),
                            "port" to info.port.toString(),
                            "type" to info.serviceType
                        )
                        foundPrinters.add(printer)
                        handler.post { callback?.invoke(foundPrinters.toList()) }
                    }
                })
            }

            override fun onServiceLost(serviceInfo: NsdServiceInfo) {}
        }

        try {
            nsdManager?.discoverServices("_ipp._tcp", NsdManager.PROTOCOL_DNS_SD, discoveryListener)
        } catch (e: Exception) {
            handler.post { callback?.invoke(emptyList()) }
        }

        handler.postDelayed({ stop() }, 10000)
    }

    fun stop() {
        try {
            discoveryListener?.let { nsdManager?.stopServiceDiscovery(it) }
        } catch (e: Exception) {}
        discoveryListener = null
    }
}
