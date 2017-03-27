

function subkeys = generatesubkeys (key, rounds)

  subkeys = cell(1, rounds);
  
  for j = 1:rounds
    subkeys{j} = bitxor(key, bitshift(1, j));
  endfor

endfunction
