/* 3. requete 3 tables*/
SELECT nom
FROM cargaison,produits,voyage
WHERE voyage_id=id_voyage and produit_id=produits.id;