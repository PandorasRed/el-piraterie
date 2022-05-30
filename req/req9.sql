/* 9. Left join des noms ports de chaque nation */
SELECT ports.nom as port, n.nom as nation FROM ports
LEFT JOIN "etape transitoire" "e t" on ports.id_port = "e t".port_id
LEFT JOIN nation n on n.id_nation = ports.nation_id;