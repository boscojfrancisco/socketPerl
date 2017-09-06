#!/usr/bin/perl -w
#tutorial http://blog.smaldone.com.ar/2006/11/06/programacion-para-redes-y-concurrencia-i/
use IO::Socket;
use threads;
use Thread::Queue;

require "procesar.pl";
#$puerto = 4444;
print "Ingrese el puerto a escuchar\n -> ";
$puerto.=<STDIN>;
chomp($puerto);# Limpia el salto de linea del ENTER
$socket=IO::Socket::INET->new(proto =>'tcp',
				LocalPort =>$puerto,
				Type      => SOCK_STREAM,
				Listen =>SOMAXCONN,
				Reuse =>1) or die "Error al iniciar el servidor";
print "Aceptando conexiones en Puerto del Servidor ==> $puerto \n";
my $client;

while ($conexion = $socket ->accept()) {

  atender($conexion);
   
    }

# while ($client = $socket->accept())
# {
#    my $pid;
#    while (not defined ($pid = fork()))
#    {
#      sleep 5;
#    }
#    if ($pid)
#    {
#        close $client;        # Only meaningful in the client 
#    }
#    else
#    {
#        $client->autoflush(1);    # Always a good idea 
#        close $socket;
#        print "pid $$ > ";
#       atender($client);
#    }
# }


