import SwiftUI
import Flutter

struct ContentView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    var body: some View {
        FlutterView(flutterEngine: flutterDependencies.flutterEngine)
            .ignoresSafeArea()
    }
}

struct FlutterView: UIViewControllerRepresentable {
    let flutterEngine: FlutterEngine
    
    func makeUIViewController(context: Context) -> UIViewController {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        return flutterViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}

