/* 1. aggrégat GROUP BY */
SELECT nom, MAX(prix)
FROM produits
GROUP BY nom;

/* 2. aggégat HAVING but avoir tous les voyages qui ont transporté plus qu'une certaine somme en tous(contient une sous requete dans le from aussi)*/
SELECT id_cargaison, SUM(prix_t)
FROM cargaison, (select prix*quantité as prix_t
                from cargaison,produits
                where cargaison.produit_id=produits.id) as tab
GROUP BY id_cargaison
HAVING SUM(prix_t) > 100000;

/* 3. requete 3 tables*/
SELECT nom
FROM cargaison,produits,voyage
WHERE voyage_id=id_voyage and produit_id=produits.id;


/* 4. sous requte WHERE recup les nom des port qui sont une arrivé d'un voyage*/
SELECT nom
FROM ports
WHERE id_port in (SELECT id_destination FROM voyage);

/* 5. fait la moyenne du prix transporté par chaque voyage*/
SELECT AVG(sum_t)
FROM  (SELECT  SUM(prix_t) as sum_t
        FROM cargaison, (select prix*quantité as prix_t
                        from cargaison,produits
                        where cargaison.produit_id=produits.id) as tab
        GROUP BY id_cargaison) as tmp;

/* 6. Requete corrélée sur le navire avec le plus grand nb de passagersmax et le nom de la nation qui le possède */
SELECT nom AS nom_nation, id_navire, passagermax
FROM navires JOIN nation n2 on navires.nation_id = n2.id_nation
WHERE passagermax >= (SELECT MAX(passagermax) FROM navires);

/* 7. Double jointure d'une même table */
SELECT n.nom as nation1, relation, n2.nom as nation2, debut FROM relation_diplo
LEFT JOIN nation n on n.id_nation = relation_diplo.nation_id1 LEFT JOIN nation n2 on n2.id_nation = relation_diplo.nation_id2
WHERE nation_id2 != relation_diplo.nation_id1;

/* 8. Requete récursive */
WITH RECURSIVE  Rounds(id_provenance, id_destination) AS
    (
        SELECT id_provenance, id_destination FROM voyage
                 UNION ALL
                 SELECT V.id_provenance, R.id_destination
                 FROM voyage V, Rounds R
                 WHERE V.id_destination = R.id_provenance
    )
SELECT * FROM Rounds
LIMIT 25;

/* 9. Left join des noms ports de chaque nation */
SELECT ports.nom as port, n.nom as nation FROM ports
LEFT JOIN "etape transitoire" "e t" on ports.id_port = "e t".port_id
LEFT JOIN nation n on n.id_nation = ports.nation_id;

