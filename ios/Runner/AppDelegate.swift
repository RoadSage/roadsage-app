import UIKit
import IntentsUI
import MobileCoreServices
import CoreSpotlight;
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var _keyset = NSMutableSet()
    var siriChannel: FlutterMethodChannel? = nil
    var plugin_name: String = "siri_suggestions"

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        siriChannel = FlutterMethodChannel(name: plugin_name,binaryMessenger: controller.binaryMessenger)
        siriChannel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "becomeCurrent") {
                self?.becomeCurrent(call: call, result: result)
            }else{
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func becomeCurrent(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? Dictionary<String, Any>
        
        // for (key,value) in arguments?{
        //      NSAssert(key != null, "key  must not be null")
        //   }
        
        let title: String = arguments?["title"] as! String
        let key: String = arguments?["key"] as! String
        
        let isEligibleForSearch: Bool = arguments?["isEligibleForSearch"] as! Bool
        
        let isEligibleForPrediction: Bool = arguments?["isEligibleForPrediction"] as! Bool
        
        let contentDescription: String = arguments?["contentDescription"] as! String
        let suggestedInvocationPhrase: String = arguments?["suggestedInvocationPhrase"] as! String
        
        if #available(iOS 9.0, *) {
            
            let actType: String = self.plugin_name + "-" + key
            let activity = NSUserActivity(activityType: actType)
            
            activity.isEligibleForSearch = isEligibleForSearch
            
            if #available(iOS 12.0, *) {
                activity.isEligibleForPrediction = isEligibleForPrediction
            }
            let attrSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attrSet.contentDescription = contentDescription
            activity.title = title;
            
            if #available(iOS 12.0, *) {
                
                // SIMULATOR HAS NOT RESPOND SELECTOR
                #if (!targetEnvironment(simulator))
                    activity.suggestedInvocationPhrase = suggestedInvocationPhrase;
                #endif
            }
            activity.contentAttributeSet = attrSet;
            


            let root = UIApplication.shared.keyWindow?.rootViewController
            root?.updateUserActivityState(activity)
            
            self._keyset.add(activity.activityType)
            activity.becomeCurrent()
            
            result(key);
            return;
            
        }
        result(nil);
        
    }



    func wake(userActivity: NSUserActivity,method:String){
        if #available(iOS 9.0, *) {
            userActivity.resignCurrent()
            userActivity.invalidate()
        }
        
        let key: String = userActivity.activityType.replacingOccurrences(of: self.plugin_name + "-", with: "")
        let args = ["title":userActivity.title as Any,"key":key, "userInfo":userActivity.userInfo as Any]
        self.siriChannel!.invokeMethod(method, arguments: args)

    }

    // MARK: Applicaiton
     public override func application(_ application: UIApplication,
                              willContinueUserActivityWithType userActivityType: String) -> Bool{
        return true;
    }

     public override func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                              restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool{
        if (self._keyset.contains(userActivity.activityType)){
            self.wake(userActivity: userActivity,method:"onLaunch")
            return true;
        }
         self.wake(userActivity: userActivity,method:"failedToLaunchWithActivity")
         return false;
        
    }
}
