
function blockarray = swapmessage (blockarray, blocksize)

  half = blocksize/2;
  mask = (2 ^ half) -1;

  for row = 1:size(blockarray)(2)
  
    data = blockarray{row};
    
    % shift the left half right half way 
    l = bitand(bitshift(data, -1 * half), mask);
    
    % mask out the left half
    r = bitand(data, mask);
   
    data = bitor(l, bitshift(r, half));
    
     blockarray{row} = data;
  
  endfor

endfunction
