import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.avaquoting.app',
  appName: 'AvaQuoting',
  webDir: 'www',
  bundledWebRuntime: false,
  android: {
    buildOptions: {
      releaseType: 'APK',
      signingType: 'apksigner',
    },
    backgroundColor: '#06101E',
    allowMixedContent: false,
    captureInput: true,
    webContentsDebuggingEnabled: false,
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 1500,
      backgroundColor: '#06101E',
      androidSpinnerStyle: 'large',
      iosSpinnerStyle: 'small',
      spinnerColor: '#2E7EE8',
      showSpinner: true,
      androidScaleType: 'CENTER_CROP',
      splashFullScreen: true,
      splashImmersive: true,
    },
  },
};

export default config;
