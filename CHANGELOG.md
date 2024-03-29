## 0.3.1

* (deprecation) deprecated helper method `getChild` in favor of `newChildLogger`
  * `getChild` will be removed after 0.4.0 release

## 0.3.0

* (feat) JsonLogger can be used to log in form of json objects
* (enh) LevelToName mapper for log levels

## 0.2.7

* (fix) renamed `kDebugMode` to `_kDebugMode` (due to an issue with flutter's native variable name, you had to hide kDebugMode on import)
* (minor) dart format .
* (minor) changed lint rules

## 0.2.6+1

* (feat) logger helper method (`getChild`)

## 0.2.5+1

* (fix) `prefer print over log` should be false in debug mode

## 0.2.4+2

* (minor): docs

## 0.2.3

* (fix) logger was not working in cli mode (can be deactivated)

## 0.2.1+1

* (Breaking) ansi logger parameters are changed
* (feat) ansi effects
* (fix) ansi color system (now changed to SGR)
    currently supporting even RGB colors (24Bit format)

## 0.1.5+1

* (fix) thrown an exception if used a detached logger

## 0.1.4+1

* (Feat) added close() method to log recorder concrete

## 0.1.3+1

* fix on exporting the contracts

## 0.1.2+1

* minor documentation and example changes

## 0.1.0+1

* initialization
