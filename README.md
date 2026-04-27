# AvaQuoting — Android APK

> Cotizador profesional de cartelería · Versión Android via Capacitor

---

## Arquitectura del sistema

```
┌─────────────────────────────────────────────────────┐
│                   AVAQUOTING MVP                    │
├─────────────────────────────────────────────────────┤
│  CAPA UI          │  HTML/CSS/JS puro (index.html)  │
│  CAPA LÓGICA      │  Vanilla JS inline              │
│  PERSISTENCIA     │  localStorage (config/precios)  │
│  RUNTIME ANDROID  │  Capacitor 6 (WebView nativo)   │
│  BUILD PIPELINE   │  GitHub Actions → APK           │
└─────────────────────────────────────────────────────┘
```

### Por qué Capacitor (y no React Native / Flutter)

La app ya funciona perfectamente como PWA. Capacitor envuelve el WebView del sistema operativo con una capa nativa mínima — **cero reescritura de código**. Es la elección correcta para apps que ya tienen UI web sólida y no necesitan APIs nativas complejas.

---

## Estructura de archivos

```
avaquoting-android/
├── .github/
│   └── workflows/
│       └── build-apk.yml       ← CI/CD: builds el APK automáticamente
├── www/                        ← La app web (fuente de verdad)
│   ├── index.html              ← App completa (lógica + UI)
│   ├── manifest.json           ← PWA manifest
│   ├── sw.js                   ← Service Worker (offline support)
│   └── icons/
│       ├── icon-180.png
│       ├── icon-192.png
│       └── icon-512.png
├── android-res/                ← Recursos Android que Capacitor usa
│   ├── strings.xml
│   ├── colors.xml
│   └── styles.xml
├── android/                    ← Generado por `npx cap add android`
│   └── app/
│       └── build/outputs/apk/ ← APK final aparece aquí
├── capacitor.config.ts         ← Config de Capacitor
├── package.json
└── README.md
```

---

## Rutas de instalación en el celular

### 🚀 OPCIÓN A — GitHub Actions (recomendada, sin instalar nada)

**Tiempo estimado: 15 minutos**

1. **Crear repositorio en GitHub**
   - Ir a https://github.com/new
   - Nombre: `avaquoting-android`
   - Público o privado, da igual

2. **Subir este proyecto**
   ```bash
   cd avaquoting-android
   git init
   git add .
   git commit -m "feat: initial release"
   git branch -M main
   git remote add origin https://github.com/TU_USUARIO/avaquoting-android.git
   git push -u origin main
   ```

3. **Esperar el build** (~5-8 minutos)
   - Ir a: `github.com/TU_USUARIO/avaquoting-android/actions`
   - Ver el workflow `Build APK` corriendo

4. **Descargar el APK**
   - Al terminar → hacer click en el workflow completado
   - Sección "Artifacts" → descargar `avaquoting-debug`
   - O ir a "Releases" → descargar el `.apk` adjunto

5. **Instalar en el celular**
   - Pasar el `.apk` al celular (WhatsApp, email, cable, Drive)
   - En Android: Ajustes → Seguridad → "Fuentes desconocidas" ✓
   - Abrir el `.apk` → Instalar

---

### 🛠️ OPCIÓN B — Build local (necesita Android Studio)

**Prerequisitos:**
- [Node.js 18+](https://nodejs.org)
- [Android Studio](https://developer.android.com/studio) con SDK 34+
- Java 17 (viene con Android Studio)

```bash
# 1. Instalar dependencias
npm install

# 2. Agregar plataforma Android
npx cap add android

# 3. Copiar recursos personalizados
cp android-res/strings.xml android/app/src/main/res/values/strings.xml
cp android-res/colors.xml  android/app/src/main/res/values/colors.xml
cp android-res/styles.xml  android/app/src/main/res/values/styles.xml

# 4. Sincronizar assets web → Android
npx cap sync android

# 5a. Abrir en Android Studio (UI)
npx cap open android
# Luego: Build → Build Bundle(s) / APK(s) → Build APK(s)

# 5b. O buildear directo por consola
cd android && ./gradlew assembleDebug

# APK en: android/app/build/outputs/apk/debug/app-debug.apk
```

---

### ⚡ OPCIÓN C — PWA directa en Android (sin APK, 2 minutos)

Si ya tenés la app hosteada en un servidor HTTPS (GitHub Pages, Netlify, etc.):

1. Abrir Chrome en Android
2. Navegar a la URL de la app
3. Menú (3 puntos) → "Agregar a pantalla de inicio"
4. La app se instala como ícono nativo (modo standalone, sin barra del browser)

> **Nota:** Esta opción NO funciona sin HTTPS. Para GitHub Pages es gratis.

---

## Cómo hostear en GitHub Pages (para Opción C)

```bash
# Desde la carpeta www/
git subtree push --prefix www origin gh-pages
```

O en la configuración del repositorio → Pages → Source: `www` folder.

URL resultante: `https://TU_USUARIO.github.io/avaquoting-android`

---

## Actualizar la app

Modificar `www/index.html` → commit → push → GitHub Actions construye nuevo APK automáticamente.

---

## Schema de datos (localStorage)

La app guarda configuración de precios en `localStorage` del WebView (persiste entre sesiones):

```
localStorage keys:
  (ninguno actualmente — los precios están en variables JS)

Extensión sugerida para v2:
  avaquoting_lonas     → JSON con precios de tipos de lona
  avaquoting_cfg       → JSON con todos los parámetros de configuración
  avaquoting_historial → Array de cotizaciones guardadas
```

---

## Roadmap v2 sugerido

| Feature | Prioridad |
|---|---|
| Persistencia de config en localStorage | Alta |
| Historial de cotizaciones | Alta |
| Compartir cotización como PDF (Capacitor Share) | Alta |
| Múltiples perfiles de precios | Media |
| Sincronización en la nube (Supabase) | Media |
| Modo oscuro/claro | Baja |

---

## Soporte

App ID: `com.avaquoting.app`  
Versión: `1.0.0`  
Target SDK: Android 14 (API 34)  
Mín. SDK: Android 7 (API 24, ~95% de dispositivos)
