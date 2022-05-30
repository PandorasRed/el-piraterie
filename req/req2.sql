/* aggégat HAVING but avoir tous les voyages qui ont transporté plus qu'une certaine somme en tous(contient une sous requete dans le from aussi)*/
SELECT id_cargaison, SUM(prix_t)
FROM cargaison, (select prix*quantité as prix_t
                from cargaison,produits
                where cargaison.produit_id=produits.id) as tab
GROUP BY id_cargaison
HAVING SUM(prix_t) > 100000;