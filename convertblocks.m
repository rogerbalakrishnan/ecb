
% convert multi byte blocks to array of bytes
function out = convertblocks (vector, blocksize)

  if (blocksize > 8)
    bytesinblock = blocksize/8;
    vectorsize = size(vector)(2);
    
    out = zeros(1, bytesinblock * vectorsize);
    
    mask = 0xff;
   
    for block = 1:vectorsize
      
      for byte = 1:bytesinblock
      
        shift = (bytesinblock - byte) * 8;
        index = (block-1) * bytesinblock + byte;
        
        out(index) = bitshift(bitand(vector(block), 
                        bitshift(mask, shift)), -1 *shift);
      endfor
      
    endfor
  
  else
    out = vector;
  endif

endfunction
