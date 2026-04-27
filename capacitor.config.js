/** @type {import('@capacitor/cli').CapacitorConfig} */
const config = {
  appId: 'com.avaquoting.app',
  appName: 'AvaQuoting',
  webDir: 'www',
  android: {
    backgroundColor: '#06101E',
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 1500,
      backgroundColor: '#06101E',
      spinnerColor: '#2E7EE8',
      showSpinner: true,
      splashFullScreen: true,
      splashImmersive: true,
    },
  },
};

module.exports = config;
