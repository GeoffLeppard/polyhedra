#  Converts unfolded polyhedron (net) produced by Antiprism into
#  a metapost file, suitable for customization.

use v5.40;

my @vertices = ();

my $infile = 'zononet.off';
my $outfile = 'zononet.mp';

open(my $fh1, '<', $infile) or die "Could not open '$infile': $!";
open(my $fh2, '>', $outfile) or die "Could not open '$outfile': $!";

print $fh2 "numeric u;\n";
print $fh2 "u = 5pt;\n";
print $fh2 "beginfig(1);\n";
print $fh2 "pickup pencircle scaled 0.1pt;\n";
print $fh2 "\n";

while (my $line = <$fh1>) {
  if ($. >= 3 && $. <= 1744) {
    chomp $line;
    my ($x, $y) = $line =~ /(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)/;
    push @vertices, [$x, $y]; 
  }
  if ($. > 1744) {
    chomp $line;
    my ($vs, $vn1, $vn2, $vn3, $vn4) = $line =~ /(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/;

    print $fh2 "draw (";
    print $fh2 join ", ", @{$vertices[$vn1]};
    print $fh2 ")--(";
    print $fh2 join ", ", @{$vertices[$vn2]};
    print $fh2 ")--(";
    print $fh2 join ", ", @{$vertices[$vn3]};
    print $fh2 ")--(";
    print $fh2 join ", ", @{$vertices[$vn4]};
    print $fh2 ")--cycle;\n";

  }
}

print $fh2 "endfig;\n";
print $fh2 "end";

close($fh1);
close($fh2);

say scalar @vertices;
