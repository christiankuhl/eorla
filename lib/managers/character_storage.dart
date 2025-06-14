export 'character_storage_none.dart'
  if (dart.library.js_interop) 'character_storage_web.dart'
  if (dart.library.io) 'character_storage_native.dart';