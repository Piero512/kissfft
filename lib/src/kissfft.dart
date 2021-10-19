import 'dart:ffi';

import 'package:kissfft/kissfft.dart';

import 'kissfft_ffi.dart';
import 'dart:io' show Platform;

class KissFft {
  static KissFftFfi ffi = _getDLL();

  static KissFftFfi _getDLL() {
    if (Platform.isAndroid) {
      return KissFftFfi(DynamicLibrary.open('libkissfft-float.so'));
    } else if (Platform.isIOS || Platform.isMacOS) {
      return KissFftFfi(DynamicLibrary.open('kissfft.framework/kissfft'));
    } else {
      return KissFftFfi(DynamicLibrary.executable());
    }
  }

  static KFFTReal initRealFFT(int fftSize) {
    return KFFTReal(ffi.kiss_fftr_alloc(fftSize, 0, nullptr, nullptr), fftSize);
  }
}
