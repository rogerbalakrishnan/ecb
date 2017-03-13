
function rc = testdriver (code, block, key, rounds, enc)

  rc = feistelnetwork(toascii(code), block, key, 2, enc);

endfunction
