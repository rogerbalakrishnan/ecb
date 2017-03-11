
function m = splitmessage(message, blocksizeinbits)

    message
    blocksizeinbits
    chars = blocksizeinbits/8
    
    if (chars > 1)
    
        size(message)(2)
        
        fill = mod(size(message)(2), chars)
        
        message = [message blanks(fill)]
        
        numrows = ceil(size(message)(2) / chars)
        
        m = cell(1, numrows);
        
        for i = 1:numrows    
        
            m{i} = message((i-1) * chars + 1:(i*chars))
                
        endfor
    else
         m = cell(1,1);
         
         m{1} = message;    
    endif

endfunction
