%
%  network.pl
%  marelle-deps
%

meta_pkg('network-recommended', [
    nmap,
    tcpdump,
    wireshark
]).

managed_pkg(nmap).
managed_pkg(tcpdump).
managed_pkg(wireshark).
