/* 4. sous requte WHERE recup les nom des port qui sont une arrivé d'un voyage*/
SELECT nom
FROM ports
WHERE id_port in (SELECT id_destination FROM voyage);