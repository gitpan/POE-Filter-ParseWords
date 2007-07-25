use inc::Module::Install;
name 'POE-Filter-ParseWords';
author 'Chris Williams <chris@bingosnet.co.uk>';
license 'perl';
version_from 'lib/POE/Filter/ParseWords.pm';
abstract_from 'lib/POE/Filter/ParseWords.pm';
requires 'POE' => 0.38;
requires 'Text::ParseWords' => 0;
WriteAll();
