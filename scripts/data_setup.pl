use Modern::Perl;
use Path::Tiny;

my @docking_receptors = glob("../OldStuff/Vina_disulfide/receptors/pdbqts/*.pdbqt");

foreach my $file (@docking_receptors) {
  path("data/receptors/pdbqts")->mkpath;
  system("cp $file data/receptors/pdbqts");
}


my @docking_ligands = glob("../OldStuff/Vina_disulfide/ligands/pdbqts/*.pdbqt");

foreach my $file (@docking_ligands) {
  path("data/ligands/pdbqts")->mkpath;
  system("cp $file data/ligands/pdbqts");
}


