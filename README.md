# Hemend Logger

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

Simple Logging Manager wraps Logging package to extends its logging capabilities

![AnsiLogger](./assets/console.png "Default AnsiLogger")

## Installation 💻

**❗ In order to start using Hemend Logger you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `hemend_logger` to your `pubspec.yaml`:

```yaml
dependencies:
  hemend_logger: <latest-version>
```

Install it:

```sh
dart pub get
```

---

## Usage

this package uses [`logging`](https://pub.dev/packages/logging) package by default but you may extend it with your own
logging system/methods

this package carries a AnsiLogger by default that can be used to print logs into terminal
but is capable of extending it to create different logging capabilities like online log recording
and or in-app interactive logging systems like toast messages

### Initiation

you may want to use the default configuration provided by [HemendLogger]
in this case simply use

```dart
HemendLogger.defaultLogger()
```

at main method of the application
if you want to change the logger level of the application use the ```Logger.root.level = <Level>``` option before
initiation of the [HemendLogger]

if you want to use Hierarchical logging make sure you have set the `hierarchicalLoggingEnabled` to true (this public variable is provided by package [`logging`](https://pub.dev/packages/logging))

otherwise if you want to use custom logging capabilities use corresponding documents in package

### Accessibility

as this package by default just is a wrapper around the default Logger implementation by [`logging`](https://pub.dev/packages/logging) package
this package only provides a mixin that may be useful in classes

```dart
class Example with LogableObject{
  @override
  String get loggerName => 'ExampleObject';
}
```

---

## Continuous Integration 🤖

Hemend Logger comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---
<!-- 
## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
``` -->

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
