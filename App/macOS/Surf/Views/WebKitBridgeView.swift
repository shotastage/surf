//
// WebKitBridgeView.swift
//
// Copyright © 2024 Shota Shimazu. All rights reserved.
// Created by Shota Shimazu on 2024/03/25.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//	https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI
import WebKit

struct WebKitBridgeView: NSViewRepresentable {
    @Binding var currentPage: String
    @State private var isLoading: Bool = true

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36 Srf/100.0.0.0"

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        loadRequest(in: webView)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // currentPageが更新されたら、新しいURLを読み込む
        loadRequest(in: nsView)
    }

    private func loadRequest(in webView: WKWebView) {
        guard let url = URL(string: currentPage) else {
            SFLogger.info("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Handling the start of page loading
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Handling page load completion
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Error handler
            SFLogger.info("Failed to load with error: \(error.localizedDescription)")
        }
    }
}

// Preview Provider if needed
#Preview("WebKit Bridge View") {
    WebKitBridgeView(currentPage: .constant("https://yahoo.co.jp"))
}
