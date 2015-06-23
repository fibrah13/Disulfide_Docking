    use Modern::Perl;
         use HackaMol;
         use HackaMol::X::Vina;
         use Math::Vector::Real;

         my @recs = glob("../Vina_disulfide/receptors/pdbqts/*.pdbqt");
         
         my ($receptor) = grep {m/3NT1/} @recs;
         my $ligand = "ligands/pdbqts/cystine_90.pdbqt",

        # my $receptor = "receptor.pdbqt";
        # my $ligand   = "lig.pdbqt",
         my $rmol     = HackaMol -> new( hush_read=>1 ) -> read_file_mol( $receptor ); 
         my $lmol     = HackaMol -> new( hush_read=>1 ) -> read_file_mol( $ligand ); 
         my $fh = $lmol->print_pdb("lig_out.pdb");

         #my @centers = map  {$_ -> xyz}
         #              grep {$_ -> name    eq "CA" }
         #               $rmol -> all_atoms;

          # @centers = map {($rmol->get_atoms($_)->xyz )} (212, 1);

         #foreach my $center ( @centers ){

             my $vina = HackaMol::X::Vina -> new(
                 receptor       => $receptor,
                 ligand         => $ligand,
                 center         => 
   V( -53.0534910516002, -30.3815186260294, -29.8956292147067),
                 size           => V( 20, 20, 20 ),
                 cpu            => 4,
                 exhaustiveness => 50,
                 exe            => '~/bin/vina',
                 scratch        => 'tmp',
             );

             my $mol = $vina->dock_mol(9); # fill mol with 9 binding configurations 

             printf ("Score: %6.1f\n", $mol->get_score($_) ) foreach (0 .. $mol->tmax);          

             $mol->print_pdb_ts([0 .. $mol->tmax], $fh); 

          # }

           $_->segid("hgca") foreach $rmol->all_atoms; #for vmd rendering cartoons.. etc
           $rmol->print_pdb("receptor.pdb");
