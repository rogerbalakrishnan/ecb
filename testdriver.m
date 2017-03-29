
function rc = testdriver (mode, code, block, key, rounds, enc, iv)

  if (mode == 0)
    if (enc == 1)
      rc = feistelnetwork_enc(mode, toascii(code), block, key, 2, toascii(iv));
    else
      rc = feistelnetwork_dec(mode, toascii(code), block, key, 2, toascii(iv));
    endif
  else
    if (enc == 1)
      rc = feistelnetwork_enc(mode, code, block, key, 2, toascii(iv));
    else
      rc = feistelnetwork_dec(mode, code, block, key, 2, toascii(iv));
    endif
  endif

endfunction
