

function [l, r] = oneround (li, ri, k, roundfnp, i)
    
    l = ri;
    
    f = roundfnp(ri, k, i);
    
    r = bitxor (li, f);
    
endfunction

