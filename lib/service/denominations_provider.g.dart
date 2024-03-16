// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denominations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalHash() => r'eff2ee8913282ce6e6da90b3368ff25b7134d374';

/// See also [total].
@ProviderFor(total)
final totalProvider = AutoDisposeProvider<double>.internal(
  total,
  name: r'totalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$totalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalRef = AutoDisposeProviderRef<double>;
String _$denominationsHash() => r'cbd51b4cdfbf5d1752ad834f9547dc790310205f';

/// See also [Denominations].
@ProviderFor(Denominations)
final denominationsProvider = NotifierProvider<Denominations, List<Denomination>>.internal(
  Denominations.new,
  name: r'denominationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$denominationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Denominations = Notifier<List<Denomination>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
