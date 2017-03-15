
function out = testdriver2 (filename, block, key, rounds, enc)

  if (enc == 1)
    raw = textread(filename, "%s");

    code = toascii(strjoin(raw, " "));
  else
    raw = textread(filename, "%2c");
    
    code = hex2dec(raw);
    
  
  endif

  out = feistelnetwork(code, block, key, 2, enc);

endfunction
