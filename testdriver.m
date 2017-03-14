
function rc = testdriver (code, block, key, rounds, enc)

  asciicode = toascii(code)

  rc = feistelnetwork(asciicode, block, key, 2, enc);

endfunction
