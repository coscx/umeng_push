package com.auwx.umeng_analytics_with_push

import com.umeng.message.UmengNotifyClickActivity
import android.util.Log
import java.util.List
import android.os.Bundle
import android.content.Intent
import android.content.ComponentName
import android.content.pm.ResolveInfo
import org.android.agoo.common.AgooConstants

class OfflineNotifyClickActivity : UmengNotifyClickActivity() {

    private var info: ResolveInfo? = null


    override fun onCreate(bundle: Bundle?) {
        super.onCreate(bundle)
    }


    override fun onMessage(intent: Intent) {
        super.onMessage(intent) //此方法必须调用，否则无法统计打开数
        val body: String? = intent.getStringExtra(AgooConstants.MESSAGE_BODY)
        Log.i(TAG, body!!)
        val mainIntent = Intent(Intent.ACTION_MAIN, null)
        mainIntent.addCategory(Intent.CATEGORY_LAUNCHER)
        mainIntent.setPackage(this.getPackageName())
//        var mApps = getPackageManager().queryIntentActivities(mainIntent, 0)
//        for (i in 0 until mApps!!.size()) {
//            info = mApps!![i]
//            val packageName: String = info.activityInfo.packageName
//            val activityName: String = info.activityInfo.name
//            val mComponentName = ComponentName(packageName, activityName)
//            val newIntent = Intent()
//            newIntent.setComponent(mComponentName)
//            newIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//            val mExtras = Bundle()
//            mExtras.putString("message", body)
//            newIntent.putExtras(mExtras)
//            startActivity(newIntent)
//            finish()
//        }
    }

    companion object {
        private val TAG: String = OfflineNotifyClickActivity::class.java.getName()
    }
}