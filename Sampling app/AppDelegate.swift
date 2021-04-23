//
//  AppDelegate.swift
//  Sampling app
//
//  Created by Назарова on 16.02.2021.
//

import UIKit
import CoreData
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // setupNotifications(on: application)
        registerLocalNotification()
        UNUserNotificationCenter.current().delegate = self
       // print("appp")
        registerBackgroundTask()
        return true
    }
    func registerBackgroundTask(){
        print("registr")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.sampling.notif", using: nil) { task in
        print("work")
            //This task is cast with processing request (BGProcessingTask)
        //self.scheduleLocalNotification()
       // self.handleFetcherTask(task: task as! BGProcessingTask)
        }
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
        (UIApplication.shared.delegate as! AppDelegate).scheduleFetcher()
    }
    func applicationWillResignActive(_ application: UIApplication){
        print("please")
        scheduleFetcher()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("apppenter")
        cancelAllPandingBGTask()
       // scheduleAppRefresh()
        scheduleFetcher()
    }
    func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    func handleFetcherTask(task: BGProcessingTask) {
        scheduleFetcher() // Recall
        
//        let queue = OperationQueue.main
//         queue.maxConcurrentOperationCount = 1
//        let calendar = Calendar.current
//        let data = UserNotification.fetchNotif().value(forKeyPath: "date") as! Date
//        //Get & Set New Data
//        if UserDefaults.standard.bool(forKey: "BeginNotif")==false{
//
//            //let currIndex = UserDefaults.standard.integer(forKey: "currIndex")
//            print("ya")
//            if  calendar.component(.hour, from: data) == calendar.component(.hour, from: Date()) && calendar.component(.minute, from: data) == calendar.component(.minute, from: Date())
//            {
//                //self.scheduleLocalNotification()//self.fireNotif(date: data)
//                UserDefaults.standard.setValue(true, forKey: "BeginNotif")
//                UserDefaults.standard.setValue(data, forKey: "CurrTimeForNotif")
//            }
//        }
//        else{
//            if  calendar.component(.hour, from: data) == calendar.component(.hour, from: Date()) && calendar.component(.minute, from: data) == calendar.component(.minute, from: Date())
//            {
//                HelpFunction.sendDefault()
//                UserDefaults.standard.setValue(false, forKey: "BeginNotif")
//                let currIndex = UserDefaults.standard.integer(forKey: "currIndex")+1
//                UserDefaults.standard.setValue(currIndex, forKey: "currIndex")
//                //UserDefaults.standard.setValue(data, forKey: "CurrTimeForNotif")
//            }
//        }
////         queue.addOperation {
////
////         }
//
//         //let lastOp = queue.operations.last
////         lastOp?.completionBlock = {
////           //task.setTaskCompleted(success: !lastOp!.isCancelled)
////         }
//        task.expirationHandler = {
//            //queue.cancelAllOperations()
//            //This Block call by System
//            //Canle your all tak's & queues
//        }
//        //
//        task.setTaskCompleted(success: true)
        //scheduleFetcher()
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
    
    func scheduleFetcher() {
        print("run")
        let request = BGProcessingTaskRequest(identifier: "com.sampling.notif")
       // request.requiresNetworkConnectivity = false // Need to true if your task need to network process. Defaults to false.
       // request.requiresExternalPower = false
        print("run1")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 30) // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
            print("run2")
        } catch {
            print("Could not schedule image featch: \(error)")
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
       // let container = NSPersistentContainer(name: "Sampling_app")
        let container = NSPersistentContainer(name: "Notification")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        //let userInfo = response.notification.request.content.userInfo
        do{
        let date: Date = response.notification.date
        let d = UserNotification.fetchNotif(date_curr: Date())
            let find_date = try UserNotification.findNearest(data: d)//try UserNotification.find(data: d, date: date)
        let curr_notif_time = find_date.value(forKeyPath: "date") as! Date
        UserNotification.deleteNearest(data: d, date: find_date)
        UserDefaults.standard.setValue(true, forKey: "notif")
            let minutes = curr_notif_time.minutes(from: Date())
            print("mmmmm",minutes,Date() )
        if abs(minutes)>20{
            var entries = UserDefaults.standard.string(forKey: "entries")
            entries!+=" F"
            UserDefaults.standard.setValue(entries, forKey: "entries")
           // UserDefaults.standard.setValue((find_date.value(forKey: "id_count") as! Int)+1, forKey: "currIndex")
                coordinateToSomeVC(name: "MainScreenViewController")
            }
            else{
                UserDefaults.standard.setValue(curr_notif_time, forKey: "CurrTimeForNotif")
                coordinateToSomeVC(name: "ViewWelcome")
            }

        
        }catch {}
        completionHandler()
    }

    private func coordinateToSomeVC(name: String)
    {
        guard let window = UIApplication.shared.keyWindow else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let yourVC = storyboard.instantiateViewController(identifier: name)
        
        let navController = UINavigationController(rootViewController: yourVC)
        navController.modalPresentationStyle = .fullScreen
        navController.navigationItem.hidesBackButton = true
        navController.setNavigationBarHidden(true, animated: false)
        //navController.pushViewController(yourVC, animated: false)
        // you can assign your vc directly or push it in navigation stack as follows:
        window.rootViewController = navController
        //window.makeKeyAndVisible()
    }
}
//extension AppDelegate {
//    func setupNotifications(on application: UIApplication) {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = self
//        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
//            if let error = error {
//                print("Failed to request autorization for notification center: \(error.localizedDescription)")
//                return
//            }
//            guard granted else {
//                print("Failed to request autorization for notification center: not granted")
//                return
//            }
//            DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//            }
//        }
//    }
//}

//extension AppDelegate {
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data -> String in
//            return String(format: "%02.2hhx", data)
//        }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//        let bundleID = Bundle.main.bundleIdentifier
//        print("Bundle ID: \(token) \(String(describing: bundleID))")
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Failed to register for remote notifications: \(error.localizedDescription)")
//    }
//
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .badge, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        defer { completionHandler() }
//        guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else { return }
//
//        let content = response.notification.request.content
//        print("Title: \(content.title)")
//        print("Body: \(content.body)")
//
//        if let userInfo = content.userInfo as? [String: Any],
//            let aps = userInfo["aps"] as? [String: Any] {
//            print("aps: \(aps)")
//        }
//    }
//
//}
//
//
extension AppDelegate {
    
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
//    func scheduleLocalNotification() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { (settings) in
//            if settings.authorizationStatus == .authorized {
//                self.fireNotification()
//            }
//        }
//    }
    
    func fireNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Experience sampling "
        notificationContent.body = "Время заполнить дневник!"
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
}

