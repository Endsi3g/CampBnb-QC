import SwiftUI

import Flutter

// The following library connects plugins with iOS platform code to this app.

import FlutterPluginRegistrant



@Observable

class FlutterDependencies {

 let flutterEngine = FlutterEngine(name: "my flutter engine")

 init() {

   // Runs the default Dart entrypoint with a default Flutter route.

   flutterEngine.run()

   // Connects plugins with iOS platform code to this app.

   GeneratedPluginRegistrant.register(with: self.flutterEngine)

 }

}



@main

struct MyApp: App {

   // flutterDependencies will be injected through the view environment.

   @State var flutterDependencies = FlutterDependencies()

   var body: some Scene {

     WindowGroup {

       ContentView()

         .environment(flutterDependencies)

     }

   }

}

