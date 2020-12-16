package com.jone.app

import android.app.Activity
import android.content.Intent
import android.os.Bundle

class SplashActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 避免从桌面启动程序后，会重新实例化入口类的activity
        if (!this.isTaskRoot) {
            val intent = intent
            if (intent != null) {
                val action = intent.action
                if (intent.hasCategory(Intent.CATEGORY_LAUNCHER) && Intent.ACTION_MAIN == action) {
                    finish()
                    return
                }
            }
        }
        startActivity(Intent(this, MainActivity::class.java))
        window.setBackgroundDrawable(null)
    }

    override fun onPause() {
        finish()
        super.onPause()
    }
}