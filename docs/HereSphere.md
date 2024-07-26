# HereSphere 

## Disable Guardian 

```sh
nix-shell -p apksigner apktool zulu8
apktool d HereSphere-v0.11.2-demo.apk
```

Open AndroidManifest.xml and find line: 

```xml
<uses-feature android:name="com.oculus.feature.PASSTHROUGH" android:required="true"/>
```

insert the following below the this line:

```xml
<uses-feature android:name="com.oculus.feature.BOUNDARYLESS_APP" android:required="true" />
```

then compile tha apk again:

```sh
apktool b HereSphere-v0.11.2-demo
keytool -genkey -v -keystore keyStore.keystore -alias app -keyalg RSA -keysize 2048 -validity 10000
apksigner sign --ks keyStore.keystore HereSphere-v0.11.2-demo/dist/HereSphere-v0.11.2-demo.apk
```

finaly uppload:

```sh
adb devices  # check if device is detected
adb install -g -r HereSphere-v0.11.2-demo/dist/HereSphere-v0.11.2-demo.apk
```
