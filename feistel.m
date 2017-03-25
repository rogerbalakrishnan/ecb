
#!/usr/bin/octave -qf

numrounds = 2;

arglist = argv();

numargs = size(arglist)(1);

if (numargs < 7)

  printf("Usage feistel <-e|-d> <-m mode> <-i iv> <-b blocksize> <-k key> <-t text | -f file>" );
else
  % encrypt or decrypt
  command    = arglist{1};
  
  modestr    = arglist{3};
  
  if (strcmp(modestr, "ECB")
    mode = 0;
    b = 5;
  else
     mode = 1;
     iv = toascii(arglist{6});
     b = 7;
  endif
  
  blocksize  = str2num(arglist{b});
  key        = str2num(arglist{b+2});
  
  % text input or file input
  datamode   = arglist{b+3};
  
  % text or filename
  datasource = arglist{b+4};

  
  switch (command)
    case "-e"
      enc = 1;
    case "-d"
      enc = 0;
    otherwise
      printf("invalid mode (%s)", mode);
      return;
  endswitch
  
  switch(datamode)
  
    case "-t"

       code = toascii(datasource);
       
    case "-f"
       % load data from file
       if (enc == 1)
          raw = textread(datasource, "%s");
          
          if (size(raw)(1) > 1)
              vec = strjoin(raw, " ");
          else
              vec = raw{1};
          endif

          code = toascii(vec);
          
       else 
       %decoding need to read encoded file
       % which is just ascii
          code = dlmread(datasource, ",");
           
       endif
       
    otherwise
      printf("Invalid datamode (%s)\n", datamode);
      return;
  endswitch
  
  out = feistelnetwork(mode, code, blocksize, key, numrounds, enc);
  
  if (strcmp (command, "-d"))
    outdata = char(out); 
  else
     outdata = out;
  endif
  
  % If we had file input write the output to a file with a .out 
  % extension
  if (strcmp(datamode, "-f"))
  
    outfile = [datasource ".out"];

    dlmwrite(outfile, outdata, ",", 0, 0);
  
  endif
  
  outdata
  
endif
