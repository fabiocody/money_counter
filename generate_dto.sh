#!/bin/sh

set -e

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter format lib/ --line-length 120
