# Examen Práctico – Unidad III

**Curso:** Desarrollo de Aplicaciones Móviles  
**Fecha:** 18 de noviembre de 2025  
**Estudiante:** Sebastian Rodrigo Arce Bracamonte

**Repositorio:** [https://github.com/KrCrimson/SM2_ExamenUnidad3](https://github.com/KrCrimson/SM2_ExamenUnidad3)

---

## Evidencias

### Estructura de carpetas
```
.github/workflows/quality-check.yml
test/main_test.dart
```

### Contenido del archivo quality-check.yml
```yaml
name: Autograding Tests

on:
  push:
  repository_dispatch:

permissions:
  checks: write
  actions: read
  contents: read

jobs:
  run-autograding-tests:
    runs-on: ubuntu-latest
    if: github.actor != 'github-classroom[bot]'
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'

      - name: flutter pub get
        run: flutter pub get

      - name: Analyze
        id: analyze
        uses: classroom-resources/autograding-command-grader@v1
        with:
          test-name: Analyze
          setup-command: flutter pub get
          command: flutter analyze
          timeout: 30
          max-score: 4

      - name: Test - User model
        id: t1
        uses: classroom-resources/autograding-command-grader@v1
        with:
          test-name: User model tests
          setup-command: flutter pub get
          command: flutter test --plain-name 'User model'
          timeout: 30
          max-score: 6

      - name: Test - All
        id: t2
        uses: classroom-resources/autograding-command-grader@v1
        with:
          test-name: All tests
          setup-command: flutter pub get
          command: flutter test
          timeout: 30
          max-score: 10

      - name: Autograding Reporter
        uses: classroom-resources/autograding-grading-reporter@v1
        env:
          ANALYZE_RESULTS: "${{steps.analyze.outputs.result}}"
          T1_RESULTS: "${{steps.t1.outputs.result}}"
          T2_RESULTS: "${{steps.t2.outputs.result}}"
        with:
          runners: analyze,t1,t2
```

### Ejecución del workflow en Actions
<img width="528" height="146" alt="image" src="https://github.com/user-attachments/assets/dd06834c-12dd-4c67-a000-444e3c86d904" />

<img width="1877" height="883" alt="image" src="https://github.com/user-attachments/assets/13066497-fe4a-419b-aaa1-d45cd721737f" />

---

## Explicación de lo realizado

1. Se creó el repositorio público **SM2_ExamenUnidad3** y se copió el proyecto móvil completo.
2. Se configuró la estructura de carpetas requerida: `.github/workflows/` y `test/`.
3. Se implementó el workflow de GitHub Actions (`quality-check.yml`) para análisis y pruebas automáticas.
4. Se desarrollaron pruebas unitarias de lógica pura en `test/main_test.dart` para el modelo `User` y la clase `Config`.
5. Se verificó la ejecución automática del workflow en cada push o pull request.

---

## Consideraciones

- El repositorio es público y cumple con la estructura solicitada.
- El workflow se ejecuta automáticamente y valida tanto el análisis de código como las pruebas unitarias.
- El informe está documentado en este README y listo para convertir a PDF.

---
