//
//  OAuth View.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/03/2025.
//

import SwiftUI
import SafariServices

// Custom View for OAuth
struct OAuthView: View {
    let googleOAuthURL = "https://accounts.google.com/o/oauth2/auth?client_id=405865461365-ai7hpaqcffg7ipemju741nk6iaomphuk.apps.googleusercontent.com&redirect_uri=https://developers.google.com/oauthplayground&response_type=code&scope=https://www.googleapis.com/auth/spreadsheets%20https://www.googleapis.com/auth/drive.file%20https://www.googleapis.com/auth/userinfo.email&access_type=offline&prompt=consent"

    // Hold a strong reference to the delegate
    @State private var safariDelegate = OAuthDelegate()

    var body: some View {
        VStack {
            Button("Log in with Google") {
                openGoogleAuth(googleOAuthURL: googleOAuthURL)
            }
        }
    }
    
    // Function to open the Google OAuth in Safari
    func openGoogleAuth(googleOAuthURL: String) {
        if let url = URL(string: googleOAuthURL) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = safariDelegate // Use the state property to hold the delegate
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(safariVC, animated: true, completion: nil)
            }
        }
    }
}

// Custom Delegate to handle Safari view URL changes
class OAuthDelegate: NSObject, SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didFinish url: URL) {
        // This will print the URL to the console every time it changes
        print("Current URL: \(url.absoluteString)")
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("Safari View Controller was dismissed.")
    }
}

#Preview {
    OAuthView()
}


