use 5.016;
use warnings;

my $gen = 0;
while () {
    ++$gen;
    $0 = "Generation: $gen";
    my $pid = fork();
    die "Error with fork: $!\n" unless defined $pid;    
    if ($pid) {
        waitpid($pid, 0);
        warn "[$$] Master is creating a new child\n";
    } else {
        my $master = getppid();
        while () {
            unless (kill 0 => $master) {
                warn "[$$] Child is creating a new child\n";
                last;
            }
            warn "[$$] works\n";
            sleep 1;
        }
    }
}