/* aggrégat GROUP BY */
SELECT nom, MAX(prix)
FROM produits
GROUP BY nom

/* aggégat HAVING but avoir tous les voyages qui ont transporté plus qu'une certaine somme en tous(contient une sous requete dans le from aussi)*/
SELECT id_cargaison, SUM(prix_t)
FROM cargaison, (select prix*quantité as prix_t
                from cargaison,produits
                where cargaison.produit_id=produits.id) as tab
GROUP BY id_cargaison
HAVING SUM(prix_t) > 100000

/* requete 3 tables*/
SELECT nom
FROM cargaison,produits,voyage
WHERE voyage_id=id_voyage and produit_id=produits.id


/* sous requte WHERE recup les nom des port qui sont une arrivé d'un voyage*/
SELECT nom
FROM ports
WHERE id_port in (SELECT id_destination FROM voyage)

/* fait la moyenne du prix transporté par chaque voyage*/
SELECT AVG(sum_t)
FROM  (SELECT  SUM(prix_t) as sum_t
        FROM cargaison, (select prix*quantité as prix_t
                        from cargaison,produits
                        where cargaison.produit_id=produits.id) as tab
        GROUP BY id_cargaison) as tmp





