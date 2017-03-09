
function out = feistelnetwork(code, blocksize, key, rounds, enc)

    half = blocksize/2;
    
    bitmask = 2^half - 1;
    
    roundfn = @round15;

    % split message up into array of blocks
    blockarray = splitmessage(code, blocksize);
    
    % if we are encrypting count up the rounds
    % if we are decrypting count down
    if (enc == 1)
        lower = 1;
        upper = rounds;
        
    else % decryption
        lower = rounds;
        upper = 1;
    endif
    
    % if we are decrypting do initial swap of blocks
    if (enc == 0)
        blockarray = swapmessage(blockarray, blocksize);
    endif
    
    for i = lower:upper
    
        for m = 1:size(blockarray)(2)
        
            block = blockarray{m};
            
            % right shift left half
            l = bitshift(block, -1 * half);
            
            % bit mask right half
            r = bitand(block, bitmask); 
        
            [ln, rn] = feistel(l, r, key, roundfn, i);
            
            outblock = bitxor(bitshift(ln, half), bitand(rn, bitmask));
            
            blockarray{m} = outblock;
        
        endfor
        
    endfor
    
    % if we are decrypting do final swap of blocks
    if (enc == 0)
        blockarray = swapmessage(blockarray, blocksize);
    endif
    
    if (size(blockarray)(2) > 1)
        % concatenate blocks into message
        out = strjoin(blockarray, " ");
    else
        out = blockarray{1};
    endif

endfunction
