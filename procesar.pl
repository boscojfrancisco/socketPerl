#!/usr/bin/perl -w
#tutorial http://blog.smaldone.com.ar/2006/11/06/programacion-para-redes-y-concurrencia-i/

sub ejecutar($$) {
    ($comando, $conexion) = @_;
     $resultado = '';
      if ($comando eq 'fecha') {
	$resultado = localtime() . "\n";
      }
      elsif ($comando eq 'v' || $comando eq 'version')  {
	       $resultado = "Version 1.0 - Universidad Nacional del Nordeste\n";
      }
      elsif ($comando eq 'scan')  {# Scanea un puerto en Local Host
           print $conexion "Scan de Puerto -> ";
           $puerto=<$conexion>;
           $puerto =~ s/\r\n|\n//g;#Borro los saltos de Lineas
           $remote = IO::Socket::INET->new(
           Proto    => "tcp",
           PeerAddr => "127.0.0.1",
           PeerPort => $puerto,
            );
           if ($remote){ 
              $resultado = "Puerto Abierto\n";           
              }
            else
              {
               $resultado = "Puerto Cerrado\n"
              }  
        }
  

if ($resultado) {
   print $conexion "OK 200\n";
   print $conexion $resultado;
  }
  elsif ($comando eq 'salir') {
   print $conexion "Bye. Fin Conexión\n"
  }
  else
   { 
    print $conexion "ERR 500\n";
  }
}

sub atender($) {
    $conexion = shift; #Toma el descriptor
    $ip = $conexion->peerhost; #La ip del Socket cliente
    $portc= $conexion->peerport;#El puerto del cliente
    print $conexion "Bienvenido uso de Soocket de Redes de Datos.\n";
    print "*Conexion establecida desde $ip y puerto del cliente $portc*]\n";
     do {
      print $conexion  "->"; 
        if ($comando = <$conexion>) {#Tomo lo que el cliente envia
            $comando =~ s/\r\n|\n//g;#Borro los saltos de Lineas
            ejecutar($comando, $conexion);# Envio el comando y el descriptor
        } else {
            $comando = 'salir';
        }
    } until ($comando eq 'salir');
    $conexion->shutdown(2);
    print "[Conexión establecida $ip]\n";
}
1;