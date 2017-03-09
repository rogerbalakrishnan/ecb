
function m = splitmessage(message, blocksize)

    blocksize_chars = blocksize/8
    
    if (blocksize_chars > 1)
    
        size(message)(2)
        
        fill = mod(size(message)(2), blocksize_chars)
        
        message = [message blanks(fill)]
        
        numrows = ceil(size(message)(2) / blocksize_chars)
        
        m = cell(1, numrows);
        
        for i = 1:numrows    
        
            m{i} = message((i-1) * blocksize_chars + 1:(i*blocksize_chars))
                
        endfor
    else
         m = cell(1,1);
         
         m{1} = message;    
    endif

endfunction
