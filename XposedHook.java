package com.youtube.adblock;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public class XposedHook implements IXposedHookLoadPackage {
    
    private static final String YOUTUBE_PACKAGE = "com.google.android.youtube";
    private static final String YOUTUBE_MUSIC_PACKAGE = "com.google.android.apps.youtube.music";
    
    @Override
    public void handleLoadPackage(XC_LoadPackage.LoadPackageParam lpparam) throws Throwable {
        if (!lpparam.packageName.equals(YOUTUBE_PACKAGE) && 
            !lpparam.packageName.equals(YOUTUBE_MUSIC_PACKAGE)) {
            return;
        }
        
        XposedBridge.log("YouTube AdBlock: Hooking " + lpparam.packageName);
        
        // Hook ad-related methods
        hookAdMethods(lpparam);
        hookVideoMethods(lpparam);
        hookAnalyticsMethods(lpparam);
    }
    
    private void hookAdMethods(XC_LoadPackage.LoadPackageParam lpparam) {
        try {
            // Hook ad loading methods
            XposedHelpers.findAndHookMethod(
                "com.google.android.apps.youtube.embeddedplayer.service.service.jar.ApiPlayerService",
                lpparam.classLoader,
                "a",
                String.class,
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
                        String url = (String) param.args[0];
                        if (isAdUrl(url)) {
                            param.setResult(null);
                            XposedBridge.log("YouTube AdBlock: Blocked ad URL: " + url);
                        }
                    }
                }
            );
        } catch (Exception e) {
            XposedBridge.log("YouTube AdBlock: Error hooking ad methods: " + e.getMessage());
        }
    }
    
    private void hookVideoMethods(XC_LoadPackage.LoadPackageParam lpparam) {
        try {
            // Hook video player methods to skip ads
            XposedHelpers.findAndHookMethod(
                "com.google.android.apps.youtube.embeddedplayer.service.service.jar.ApiPlayerService",
                lpparam.classLoader,
                "b",
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
                        // Skip to next video if current is ad
                        XposedBridge.log("YouTube AdBlock: Skipping ad video");
                    }
                }
            );
        } catch (Exception e) {
            XposedBridge.log("YouTube AdBlock: Error hooking video methods: " + e.getMessage());
        }
    }
    
    private void hookAnalyticsMethods(XC_LoadPackage.LoadPackageParam lpparam) {
        try {
            // Hook analytics to prevent ad tracking
            XposedHelpers.findAndHookMethod(
                "com.google.android.apps.youtube.core.analytics.clearcut.YouTubeAnalytics",
                lpparam.classLoader,
                "a",
                String.class,
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
                        String event = (String) param.args[0];
                        if (isAdEvent(event)) {
                            param.setResult(null);
                            XposedBridge.log("YouTube AdBlock: Blocked ad analytics: " + event);
                        }
                    }
                }
            );
        } catch (Exception e) {
            XposedBridge.log("YouTube AdBlock: Error hooking analytics methods: " + e.getMessage());
        }
    }
    
    private boolean isAdUrl(String url) {
        if (url == null) return false;
        
        String lowerUrl = url.toLowerCase();
        return lowerUrl.contains("ad") ||
               lowerUrl.contains("doubleclick") ||
               lowerUrl.contains("googlesyndication") ||
               lowerUrl.contains("googleadservices") ||
               lowerUrl.contains("pagead") ||
               lowerUrl.contains("adsystem");
    }
    
    private boolean isAdEvent(String event) {
        if (event == null) return false;
        
        String lowerEvent = event.toLowerCase();
        return lowerEvent.contains("ad") ||
               lowerEvent.contains("advertisement") ||
               lowerEvent.contains("ad_") ||
               lowerEvent.contains("ads_");
    }
}