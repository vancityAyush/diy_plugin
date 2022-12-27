# diy

A new Flutter plugin project.

flutter pub run build_runner build --delete-conflicting-outputs
## Getting Started
Copy And Paste Plugin in your Project Folder

Add this to your package's pubspec.yaml file:
minSdkVersion 21

diy:
    path: ../diy


diy:
    git:
      url: https://github.com/hemantam1/diy_plugin.git
      ref: main



       <provider
           android:name="com.pichillilorenzo.flutter_inappwebview.InAppWebViewFileProvider"
           android:authorities="${applicationId}.flutter_inappwebview.fileprovider"
           android:exported="false"
           android:grantUriPermissions="true">
           <meta-data
               android:name="android.support.FILE_PROVIDER_PATHS"
               android:resource="@xml/provider_paths" />
       </provider>

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.GALLERY"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
