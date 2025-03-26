program go_to;

label
  sem;

var
  n: string;

begin
  sem:
      write('Něco napiš: ');
      read(n);
      writeln('Napsal si: ', n);
      goto sem;
end.

