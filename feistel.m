
#!/usr/bin/octave -qf

numrounds = 2;

arglist = argv();

numargs = size(arglist)(1);

if (numargs < 5)

  printf("Usage feistel <-e|-d> <-b blocksize> <-k key> <-t text | -f file>");
else
  
  blocksize = arglist{3};
  datamode  = arglist{6};
  key       = arglist{5};
  
  switch (arglist{1})
    case "-e"
      enc = 1;
    case "-d"
      enc = 0;
    otherwise
      printf("invalid mode (%s)", mode);
      return;
  endswitch
  
  switch(arglist{6})
  
    case "-t"
      code = toascii(arglist{7});
    case "-f"
       % load data from file
       raw = textread(arglist{7}, "%s");
       
       code = toascii(strjoin(raw, " "));
       
    otherwise
      printf("Invalid datamode (%s)\n", datamode);
      return;
  endswitch
  
  outdata = feistelnetwork(code, blocksize, key, numrounds, enc);
  
  if (strcmp(datamode, "-f"))
  
    outfile = [arglist{7} ".out"]
    dlmwrite(outfile, char(outdata));
  
  endif
  
endif
