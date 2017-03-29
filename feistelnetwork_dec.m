
%
% mode ECB - 0 CBC-1
% code is ascii equivalent of the text
% block size in bitset
% key value 
% number of rounds
%
function out = feistelnetwork_dec(mode, code, blocksize, key, numrounds, iv)

    half = blocksize/2;
    
    bitmask = 2^half - 1;
    
    roundfn = @round15;
    
    % in cbc mode use iv as first prev value
    if (mode ==1)
      subkey = generatesubkeys(key, numrounds);
      prevvalue = iv;
    endif

    % split message up into array of blocks
    blockarray = splitmessage(code, blocksize);

    % for each block
    for m = 1:size(blockarray)(2)
    
      % get the block to encrypt/decrypt
      dblock = blockarray{m};
      
      % if we are decrypting do initial swap of blocks
      block = swapmessage(dblock, blocksize);
    
      % do the rounds 
      for i = numrounds:-1:1
        
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
      block = swapmessage(block, blocksize);
          
      if (mode == 1)
        block = bitxor(block, prevvalue);

        % use the encrypted block as the next prev value
        prevvalue = dblock;
      endif
      
      blockarray{m} = block;
        
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
