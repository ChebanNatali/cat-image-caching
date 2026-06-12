# Cat Image Caching

Flutter-приложение для фоновой загрузки и кэширования изображений котов
с [cataas.com](https://cataas.com).

---

## Требования

FVM Версия 3.x                           
Flutter = 3.32.8 (управляется через FVM)
Dart = 3.8.1+                         
Android NDK = 27.0.12077973         
iOS deployment target = 14.0+
Xcode 15+ (только для iOS)
CocoaPods актуальная версия (только для iOS)

---

## Установка

### 1. Установить FVM

```bash
dart pub global activate fvm
```

Или через Homebrew (macOS):

```bash
brew install fvm
```

### 2. Клонировать репозиторий

```bash
git clone https://github.com/ChebanNatali/cat-image-caching.git
cd cat-image-caching/catimage
```

### 3. Установить нужную версию Flutter

```bash
fvm install
```

FVM автоматически прочитает версию `3.32.8` из `.fvm/fvm_config.json`.

### 4. Установить зависимости

```bash
fvm flutter pub get
```

## Запуск

### Android

```bash
fvm flutter run
```

Перед первым запуском убедитесь, что установлен Android NDK версии `27.0.12077973`.
В Android Studio: **SDK Manager → SDK Tools → NDK (Side by side)**.

### iOS

```bash
fvm flutter run
```

Открыть симулятор или подключить устройство перед запуском.
Для запуска на реальном устройстве потребуется настроить подпись в Xcode:
**Runner.xcworkspace → Signing & Capabilities → Team**.

---

## Сборка

### Android APK

```bash
fvm flutter build apk --release
```

Файл сборки будет назван по шаблону:
`cat-release-v<версия>-<код>.apk`

### iOS IPA

```bash
fvm flutter build ipa --release
```

---

### Дополнительная информация

#### Фоновая загрузка

Приложение использует **WorkManager** для периодической загрузки изображений.

Активный режим — **один раз в сутки** (`registerOnceToday`).
Повторная загрузка не происходит, если изображение уже было скачано сегодня.

