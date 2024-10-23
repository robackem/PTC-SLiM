#!/usr/bin/perl

# load needed modules
use strict;
use warnings;
use Getopt::Std;

# define the usage statement variable that will be read if not all the options are met
  my $usage = "\n$0 -a codon_key_file -i input_cDNA_file -o output_file -h help\n";

# call the options from the command line (no : after h means it is not required) 
  our ($opt_a, $opt_i, $opt_o, $opt_h);
  getopts("a:i:o:h") or die "$usage";

# print the usage statement and exit the script if not all the options are met or if -h is used
  if ( (!(defined $opt_a)) or (!(defined $opt_i)) or (!(defined $opt_o)) or (defined $opt_h) )
  { print "$usage"; exit; }

# open the two input files
  open (my $annot_file, '<', $opt_a) or die "Cannot open annotation file\n";
  open (my $in_file, '<', $opt_i) or die "Cannot open input file\n";

# open output file
  open (my $out_file, '>', $opt_o) or die "Cannot open output file \n";

################################################################################################


# Generate key of probabilities

my %hash;

while (my $line = <$annot_file>) 
  {  chomp($line);
     my @fields = split('\t', $line);
     my $keys = $fields[0];
     my $value = $fields[1];
     $hash{$keys} = $value;
   }

     
 # read the file line by line   
  while(my $line = <$in_file>)

     
  {  chomp $line;
     my ($transcript, $sequence) = $line =~ /^(.+?);(.+)$/; # get transcript ID and cDNA sequence 
     my $seq = substr($sequence, 0, -3);      # subtract off the existing stop codon from the cDNA sequence
     my @codons = $seq =~ /(.{3})/g;          # split $seq into codons (chunks of three characters each)
     # Initialize variables for storing sum and count for each codon
     my %codon_sum;
     my %codon_count;
     # Generate strings for each codon
     foreach my $codon (@codons) {
       for my $i (1..3) {
	 my $string = "$codon:$i";

        # Look up the string in the hash and update sum and count
        if (exists $hash{$string}) {
            $codon_sum{$codon} += $hash{$string};
            $codon_count{$codon}++;}
    }
}

# Calculate the total sum and count across all codons
my $total_sum = 0;
my $total_count = 0;
     foreach my $codon (keys %codon_sum) {
       $total_sum += $codon_sum{$codon};
       $total_count += $codon_count{$codon};
   }

# Calculate the average value across all codons for the transcript
     my $average_value = $total_sum / $total_count;
# Scale to include SNP probability (mutation rate in Malawi cichlids estimated @ 3.5 × 10−9 per base pair per generation)
     my $mutation_rate = 0.0000000035;
     my $scaled_mutrate = $average_value * $mutation_rate;
     print $out_file "$transcript\t$scaled_mutrate\n";

   }


close $in_file;
close $out_file;
