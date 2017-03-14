
function m = splitmessage(message, blocksizeinbits)

    charsinblock = blocksizeinbits/8;
    
    if (charsinblock >= 1)
    
        size(message)(2);
        
        fill = mod(size(message)(2), charsinblock);
        
        blankfill = zeros(1, fill) + toascii(' ');
        
        message = [message blankfill];
        
        numrows = ceil(size(message)(2) / charsinblock);
        
        m = cell(1, numrows);
        
        for i = 1:numrows    
        
            m{i} = message((i-1) * charsinblock + 1:(i*charsinblock));
                
        endfor
    else
         m = cell(1,1);
         
         m{1} = message;    
    endif
    

endfunction
