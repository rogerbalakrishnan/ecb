
function m = splitmessage(message, blocksizeinbits)

    charsinblock = blocksizeinbits/8;
    
    if (charsinblock >= 1)
    
        size(message)(2);
        
        fill = mod(size(message)(2), charsinblock);
        
        blankfill = zeros(1, fill) + toascii(' ');
        
        message = [message blankfill];
        
        numrows = ceil(size(message)(2) / charsinblock);
        
        m = cell(1, numrows);
        
        for r = 1:numrows    
        
            block = message((r-1) * charsinblock + 1:(r*charsinblock));
            
            % convert multi byte vector to a single number
            value = 0;   
            for i = 1:charsinblock
             
              value = value + block(i) * power(256, (i-1));
                 
            endfor
            
            m{r} = value;
        endfor
    else
         m = cell(1,1);
         
         m{1} = message;    
    endif
    

endfunction
