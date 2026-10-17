# SOSs AI backend

This Dart Shelf service keeps the OpenRouter API key outside the Flutter app
and returns sensory-support suggestions for caregiver review. It never
controls devices or applies adjustments automatically.

## Run locally

From the SOSs repository root:

```bash
cd soss_ai_backend
dart pub get
export OPENROUTER_API_KEY="your-openrouter-key"
dart run bin/server.dart
```

The server listens on port `8080`.

The backend calls OpenRouter's Chat Completions endpoint with model
`nvidia/nemotron-3.5-super-vl`. The API key is read from
`OPENROUTER_API_KEY` and sent as a Bearer token; it is never stored in the
Flutter app.

Check that it is running:

```bash
curl http://127.0.0.1:8080/health
```

The Flutter app can connect to it with:

```bash
flutter run --dart-define=SOS_AI_BASE_URL=http://127.0.0.1:8080
```

Use `http://10.0.2.2:8080` for an Android emulator. Use fictional or
anonymised notes while testing; do not send confidential personal data to the
development endpoint.
