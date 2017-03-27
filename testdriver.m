
function rc = testdriver (mode, code, block, key, rounds, enc, iv)

  if (mode == 0)
    rc = feistelnetwork(mode, toascii(code), block, key, 2, enc);
  else
    rc = feistelnetwork(mode, toascii(code), block, key, 2, enc, toascii(iv));
  endif

endfunction
