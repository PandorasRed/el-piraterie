/* 5. fait la moyenne du prix transporté par chaque voyage*/
SELECT AVG(sum_t)
FROM  (SELECT  SUM(prix_t) as sum_t
        FROM cargaison, (select prix*quantité as prix_t
                        from cargaison,produits
                        where cargaison.produit_id=produits.id) as tab
        GROUP BY id_cargaison) as tmp;