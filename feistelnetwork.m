
%
% code is ascii equivalent of the text
% block size in bitset
% key value 
% number of rounds
% enc 1 to encryt, 0 to decrypting
%
function out = feistelnetwork(code, blocksize, key, numrounds, enc)

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
    
    % if we are decrypting do initial swap of blocks
    if (enc == 0)
        blockarray = swapmessage(blockarray, blocksize);
    endif

    for i = lower:step:upper
 
        for m = 1:size(blockarray)(2)
        
            block = blockarray{m};
            
            % right shift left half
            l = bitshift(block, -1 * half);
            
            % bit mask right half
            r = bitand(block, bitmask);
        
            [ln, rn] = oneround(l, r, key, roundfn, i);
            
            blockarray{m} = bitxor(bitshift(ln, half), bitand(rn, bitmask));
        
        endfor
        
    endfor
    
    % if we are decrypting do final swap of blocks
    if (enc == 0)
        blockarray = swapmessage(blockarray, blocksize);
    endif
    
    blockarray
    char(blockarray)
    
    if (size(blockarray)(2) > 1)
        % concatenate blocks into message
        out = strjoin(char(blockarray), "");
    else
        out = char(blockarray{1});
    endif

endfunction
