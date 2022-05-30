/* 7. Double jointure d'une même table */
SELECT n.nom as nation1, relation, n2.nom as nation2, debut FROM relation_diplo
LEFT JOIN nation n on n.id_nation = relation_diplo.nation_id1 LEFT JOIN nation n2 on n2.id_nation = relation_diplo.nation_id2
WHERE nation_id2 != relation_diplo.nation_id1;