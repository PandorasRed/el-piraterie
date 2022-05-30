SELECT nom, MAX(prix)
FROM produits
GROUP BY nom;