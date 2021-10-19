import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:kissfft/src/kissfft.dart';

import 'kissfft_ffi.dart';

class KFFTReal {
  Pointer<kiss_fftr_state> handle;
  final int fftSize;

  KFFTReal(this.handle, this.fftSize) : assert(handle != nullptr);

  void calculateRealFFTAbs(
      Pointer<Float> data, int length, Pointer<Float> out) {
    assert(length == fftSize);
    assert(handle != nullptr);
    var arena = Arena();
    var outputsize = fftSize ~/ 2 + 1;
    try {
      var result = arena.call<kiss_fft_cpx>(outputsize);
      KissFft.ffi.kiss_fftr(handle, data, result);
      var list = out.asTypedList(outputsize);
      for (var i = 0; i < outputsize; i++) {
        var cpx = result.elementAt(i).ref;
        list[i] = sqrt(cpx.i * cpx.i + cpx.r * cpx.r);
      }
    } finally {
      arena.releaseAll();
    }
  }

  void dispose() {
    malloc.free(handle);
    handle = nullptr;
  }
}
