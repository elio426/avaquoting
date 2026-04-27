#!/bin/bash
# setup.sh — Configura el proyecto AvaQuoting Android localmente
# Ejecutar: bash setup.sh

set -e

echo ""
echo "╔══════════════════════════════════╗"
echo "║   AvaQuoting — Setup Android     ║"
echo "╚══════════════════════════════════╝"
echo ""

# ── Verificar Node.js ──────────────────────────────────────────────────
if ! command -v node &> /dev/null; then
  echo "❌  Node.js no está instalado. Instalalo desde https://nodejs.org"
  exit 1
fi
NODE_VER=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VER" -lt 18 ]; then
  echo "❌  Necesitás Node.js 18 o superior (tenés $(node -v))"
  exit 1
fi
echo "✅  Node.js $(node -v)"

# ── Verificar Java ────────────────────────────────────────────────────
if ! command -v java &> /dev/null; then
  echo "❌  Java no está instalado. Instalalo con Android Studio."
  echo "    https://developer.android.com/studio"
  exit 1
fi
echo "✅  Java $(java -version 2>&1 | head -1)"

# ── Verificar ANDROID_HOME ────────────────────────────────────────────
if [ -z "$ANDROID_HOME" ]; then
  echo "⚠️   ANDROID_HOME no está definido."
  echo "    Si tenés Android Studio, agregá esto a tu .bashrc/.zshrc:"
  echo '    export ANDROID_HOME=$HOME/Library/Android/sdk'
  echo '    export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools'
  echo ""
  echo "    Para build sin Android Studio local, usá GitHub Actions (ver README)."
  read -p "¿Continuar de todas formas? (s/N): " yn
  [[ "$yn" =~ ^[Ss]$ ]] || exit 0
fi

# ── Instalar dependencias npm ─────────────────────────────────────────
echo ""
echo "📦 Instalando dependencias..."
npm install

# ── Agregar plataforma Android ────────────────────────────────────────
echo ""
echo "📱 Configurando plataforma Android..."
if [ ! -d "android" ]; then
  npx cap add android
else
  echo "   (android/ ya existe, saltando)"
fi

# ── Copiar recursos personalizados ────────────────────────────────────
echo ""
echo "🎨 Copiando recursos de marca..."
cp android-res/strings.xml android/app/src/main/res/values/strings.xml
cp android-res/colors.xml  android/app/src/main/res/values/colors.xml
cp android-res/styles.xml  android/app/src/main/res/values/styles.xml

# ── Sincronizar assets web ────────────────────────────────────────────
echo ""
echo "🔄 Sincronizando assets web → Android..."
npx cap sync android

# ── Resultado ─────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   ✅  Setup completado                           ║"
echo "╠══════════════════════════════════════════════════╣"
echo "║                                                  ║"
echo "║  Para abrir en Android Studio:                   ║"
echo "║    npx cap open android                          ║"
echo "║                                                  ║"
echo "║  Para buildear APK por consola:                  ║"
echo "║    cd android && ./gradlew assembleDebug         ║"
echo "║                                                  ║"
echo "║  APK en:                                         ║"
echo "║  android/app/build/outputs/apk/debug/            ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
