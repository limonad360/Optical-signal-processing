startIndex = 1;

fname = 'BLUE_10.dat';
f_blue = fopen(fname, 'r');
blue10x = double(cell2mat(textscan(f_blue, '%d', 'Delimiter', {','})));
blue10 = blue10x(startIndex:end);

fnameRef = 'BLUE_REF.dat';
f_blueRef = fopen(fnameRef, 'r');
blue_refx = double(cell2mat(textscan(f_blueRef, '%d', 'Delimiter', {','})));
blue_ref = blue_refx(startIndex:end);

fnameNone10 = 'None10.dat';
f_none10 = fopen(fnameNone10, 'r');
none10x = double(cell2mat(textscan(f_none10, '%d', 'Delimiter', {','})));
none10 = none10x(startIndex:end);

fnameNoneRef = 'NoneRef.dat';
f_noneRef = fopen(fnameNoneRef, 'r');
none_refx = double(cell2mat(textscan(f_noneRef, '%d', 'Delimiter', {','})));
none_ref = none_refx(startIndex:end);

k = 1.6/100;
Ref = ((blue10 - none10)./((blue_ref - none_ref)*k));
Ref_ok = Ref(startIndex:end);

Ref_smooth = smooth(Ref_ok, 1000, 'moving');
plot(Ref_smooth)
grid on

