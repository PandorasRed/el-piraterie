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