
function newblock = swapmessage (block, blocksize)

  half = blocksize/2;
  chars = half/8;

  if (chars < 1)
  
    mask = (2 ^ half) -1;
  
    data = blockarray{row};
    
    % shift the left half right half way 
    l = bitand(bitshift(data, -1 * half), mask);
    
    % mask out the left half
    r = bitand(data, mask);
   
    data = bitor(l, bitshift(r, half));
  
  else
  
    l = block(1:half);
    
    r = block(half+1: end);
    
    data = [r l]
  
  endif
  
  newblock = data;

endfunction
