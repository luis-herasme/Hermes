%
% Copyright 2001 Free Software Foundation, Inc.
%
% This file is part of GNU Radio
%
% SPDX-License-Identifier: GPL-3.0-or-later
%
%

function v = write_uchar_binary (data, filename)

  %% usage: write_short_binary (data, filename)
  %%
  %%  open filename and write data to it as 8 bits uchars
  %%

  if ((m = nargchk (2,2,nargin)))
    usage (m);
  endif;

  f = fopen (filename, "wb");
  if (f < 0)
    v = 0;
  else
    v = fwrite (f, data, "uchar");
    fclose (f);
  endif;
endfunction;
