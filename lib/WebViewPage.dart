import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './constants/credentials.dart';

class WebViewPage extends StatefulWidget {
  final String actionType;
  WebViewPage({this.actionType});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String statusWord = "";

  setPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("status", statusWord);
  }

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    bool _isClocked = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("TalentSprint"),
      ),
      body: WebView(
        initialUrl: "https://talentsprint.darwinbox.in",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          _controller.evaluateJavascript(
              "document.getElementById('UserLogin_username').value='" +
                  username +
                  "';");
          _controller.evaluateJavascript(
              "document.getElementById('UserLogin_password').value='" +
                  password +
                  "';");
          _controller.evaluateJavascript(
              "document.getElementById('login-submit').click();");
        },
        onPageFinished: (String url) async {
          if ( widget.actionType == "clock" && !_isClocked ) {
            try {
              _controller.evaluateJavascript(
                  "document.getElementById('attendance-logger-widget').click();");
              _isClocked = true;
            } catch (err) {
              print(err);
            }
          } else if ( widget.actionType == "login" || _isClocked) {
            String temp = await _controller.evaluateJavascript(
                "document.querySelector('.tool_tip_btn').innerText;");
            setState(() {
              statusWord = temp;
              print(statusWord);
            });
            setPrefs();
          }
        },
      ),
    );
  }
}
