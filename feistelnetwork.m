
%
% mode ECB - 0 CBC-1
% code is ascii equivalent of the text
% block size in bitset
% key value 
% number of rounds
% enc 1 to encryt, 0 to decrypting
%
function out = feistelnetwork(mode, code, blocksize, key, numrounds, enc, iv)

    half = blocksize/2;
    
    bitmask = 2^half - 1;
    
    roundfn = @round15;

    % split message up into array of blocks
    blockarray = splitmessage(code, blocksize);
    
    % if we are encrypting count up the rounds
    % if we are decrypting count down
    if (enc == 1)
        lower = 1;
        upper = numrounds;
        step = 1;
        
    else % decryption
        lower = numrounds;
        upper = 1;
        step = -1;
    endif
    
    if (mode ==1)
      subkey = generatesubkeys(key, numrounds)
    endif
    
    if (mode == 1)
      prevvalue = iv;
    endif

    % for each block
    for m = 1:size(blockarray)(2)
    
      % get the bloc to encrypt/decrypt
      block = blockarray{m}
      
      % if we are decrypting do initial swap of blocks
      if (enc == 0)
          block = swapmessage(block, blocksize);
      endif
      
      % if cbc and encrypting we need to or the block and the 
      % prev value
      if (enc == 1 && mode ==1)
        block = bitxor(block,prevvalue);
      endif
    
      % do the rounds 
      for i = lower:step:upper
        
          % right shift left half
          l = bitshift(block, -1 * half);
          
          % bit mask right half
          r = bitand(block, bitmask);
      
          if (mode ==0)
            [ln, rn] = oneround(l, r, key, roundfn, i);
          else
            [ln, rn] = oneround(l, r, subkey{1,i}, roundfn, i);
          endif
          
          block = bitxor(bitshift(ln, half), bitand(rn, bitmask));
        
      endfor
        
      % if we are decrypting do final swap of blocks
      if (enc == 0)
          block = swapmessage(block, blocksize);
          
          if (mode == 1)
            block = bitxor(block, prevvalue)
          endif
      endif
      
      if (mode == 1)
        prevvalue = block;
      endif
        
    endfor
    
    if (size(blockarray)(2) > 1)
        mat = cell2mat(blockarray);
        vec = mat(:)';
    else
        vec = blockarray{1};
    endif
    
    % convert to byte array
    out = convertblocks(vec, blocksize);
    

endfunction
