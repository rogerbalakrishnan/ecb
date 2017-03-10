
numrounds = 8;

arglist = argv()

numargs = size(arglist)(1)

if (numargs < 5)

  printf("Usage feistel <-e|-d> <-b blocksize> <-k key> <-t text | -f file>");
else
  
  blocksize = arglist{3};
  
  datamode = arglist{4};
  
  key = arglist{5};
  
  switch (arglist{1})
    case "-e"
      fn = @feistelcrypt;
    case "-d"
      fn = @feisteldecrypt;
    otherwise
      printf("invalid mode (%s)", mode);
      return;
  endswitch
  
  switch(arglist{6})
  
    case "-t"
      fn(arglist{7}, blocksize, key, numrounds)
    case "-f"
       % load data from file
       raw = textread(arglist{7}, "%s");
       data = strjoin(raw, " ");
       
       fn(data, blocksize, key, numrounds)
       
    otherwise
      printf("Invalid datamode (%s)\n", datamode);
  endswitch
  
  
endif
