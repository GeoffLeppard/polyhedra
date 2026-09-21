use v5.40;

my @vertices = ();
my @faces = ();

my $infile = 'zononet.off';
my $outfile = 'zononet.mp';

open(my $fh1, '<', $infile) or die "Could not open '$infile': $!";
open(my $fh2, '>', $outfile) or die "Could not open '$outfile': $!";

while (my $line = <$fh1>) {
  next if $. <= 2;
  chomp $line;
  if (2 < $. and $. <= 1744) {
    my ($x, $y) = $line =~ /(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)/;
    push @vertices, [$x, $y]; 
  }
  if ($. >= 1745) {
    my ($vs, $vn1, $vn2, $vn3, $vn4) = $line =~ /(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/;
    push @faces, [$vertices[$vn1], $vertices[$vn2], $vertices[$vn3], $vertices[$vn4]];
    #say join ' ', @{$vertices[$vn1]};
  }
}

close($fh1);

print $fh2 "numeric u;\n";
print $fh2 "u = 1pt;\n";
print $fh2 "\n";


for my $n (1..scalar @faces);

my (
print $fh2 "draw (", $vertices[$faces[$n][1], ",", 
                     $vertices[$faces[$n][2], ",",
                     $vertices[$faces[$n][3], ",",
                     $vertices[$faces[$n][4] ");";



close($fh2);

say scalar @vertices;
say scalar @faces;
