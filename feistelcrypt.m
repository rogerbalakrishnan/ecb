
function crypt = feistelcrypt(message, blocksize, key, rounds)

    crypt = feistelnetwork(message, blocksize, key, rounds, 1);

endfunction
