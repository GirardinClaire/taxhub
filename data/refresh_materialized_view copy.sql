TRUNCATE TABLE taxonomie.vm_taxref_hierarchie;
INSERT INTO taxonomie.vm_taxref_hierarchie
SELECT tx.regne, tx.phylum, tx.classe, tx.ordre, tx.famille, tx.sous_famille, tx.tribu, tx.cd_nom, tx.cd_ref, lb_nom, trim(id_rang) AS id_rang, t.nb_tx_tr, s.nb_tx_sfm, f.nb_tx_fm, o.nb_tx_or, c.nb_tx_cl, p.nb_tx_ph, r.nb_tx_kd FROM taxonomie.taxref tx
  LEFT JOIN (SELECT tribu ,count(*) AS nb_tx_tr  FROM taxonomie.taxref where id_rang NOT IN ('TR') GROUP BY  tribu) t ON t.tribu = tx.tribu
  LEFT JOIN (SELECT sous_famille ,count(*) AS nb_tx_sfm  FROM taxonomie.taxref where id_rang NOT IN ('SFM') GROUP BY  sous_famille) s ON s.sous_famille = tx.sous_famille
  LEFT JOIN (SELECT famille ,count(*) AS nb_tx_fm  FROM taxonomie.taxref where id_rang NOT IN ('FM') GROUP BY  famille) f ON f.famille = tx.famille
  LEFT JOIN (SELECT ordre ,count(*) AS nb_tx_or FROM taxonomie.taxref where id_rang NOT IN ('OR') GROUP BY  ordre) o ON o.ordre = tx.ordre
  LEFT JOIN (SELECT classe ,count(*) AS nb_tx_cl  FROM taxonomie.taxref where id_rang NOT IN ('CL') GROUP BY  classe) c ON c.classe = tx.classe
  LEFT JOIN (SELECT phylum ,count(*) AS nb_tx_ph  FROM taxonomie.taxref where id_rang NOT IN ('PH') GROUP BY  phylum) p ON p.phylum = tx.phylum
  LEFT JOIN (SELECT regne ,count(*) AS nb_tx_kd  FROM taxonomie.taxref where id_rang NOT IN ('KD') GROUP BY  regne) r ON r.regne = tx.regne
WHERE id_rang IN ('KD','PH','CL','OR','FM', "SFM", "TR") AND tx.cd_nom = tx.cd_ref;

REFRESH MATERIALIZED VIEW CONCURRENTLY taxonomie.vm_taxref_list_forautocomplete;
 
REFRESH MATERIALIZED VIEW taxonomie.vm_classe;
REFRESH MATERIALIZED VIEW taxonomie.vm_famille;
REFRESH MATERIALIZED VIEW taxonomie.vm_group1_inpn;
REFRESH MATERIALIZED VIEW taxonomie.vm_group2_inpn;
REFRESH MATERIALIZED VIEW taxonomie.vm_ordre;
REFRESH MATERIALIZED VIEW taxonomie.vm_phylum;
REFRESH MATERIALIZED VIEW taxonomie.vm_regne;
REFRESH MATERIALIZED VIEW taxonomie.vm_sous_famille;
REFRESH MATERIALIZED VIEW taxonomie.vm_tribu;

