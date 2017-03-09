
function message = feisteldecrypt(crypt, blocksize, key, rounds)
    
    message = feistelnetwork(crypt, blocksize, key, rounds, 0);

endfunction
