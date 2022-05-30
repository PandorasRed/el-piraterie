/* 6. Requete corrélée sur le navire avec le plus grand nb de passagersmax et le nom de la nation qui le possède */
SELECT nom AS nom_nation, id_navire, passagermax
FROM navires JOIN nation n2 on navires.nation_id = n2.id_nation
WHERE passagermax >= (SELECT MAX(passagermax) FROM navires);