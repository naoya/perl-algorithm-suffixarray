use inc::Module::Install;

perl_version '5.8.1';

name 'Algorithm-SuffixArray';
all_from 'lib/Algorithm/SuffixArray.pm';

requires 'perl' => '5.8.1';
requires 'Algorithm::DivSufSort';
requires 'Class::Accessor::Lvalue::Fast';

auto_install;
WriteAll;
