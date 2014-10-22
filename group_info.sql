# Характеристика группы
CREATE OR REPLACE VIEW user_groups
AS
SELECT guid, user.uid, religion, first_name
  FROM `user_subscriptions`
    JOIN `user` ON `user`.uid = `user_subscriptions`.uid

SELECT g0 "Группа", c_n0 "Количество человек",
	r1 "Top-1 Религия Название", r_c1 "Top-1 Религия Количество",
	r2 "Top-2 Религия Название", r_c2 "Top-2 Религия Количество",
	f1 "Top-1 Имя Название", f_c1 "Top-1 Имя Количество",
	f2 "Top-2 Имя Название", f_c2 "Top-2 Имя Количество"
FROM (
	SELECT guid g0, COUNT(uid) c_n0 FROM `user_groups`
	GROUP BY guid
) t0, ( # выбираем топ-1 и топ-2 для имен
	SELECT g2, f1, f_c1, f2, f_c2 from (
	    SELECT guid g1, first_name f1, COUNT(first_name) f_c1 FROM `user_groups`
	    GROUP BY guid, first_name
	) i1, (
	    SELECT guid g2, first_name f2, COUNT(first_name) f_c2 FROM `user_groups`
	    GROUP BY guid, first_name
	) i2 WHERE g1=g2 HAVING f_c2 < f_c1
) t1, ( # выбираем топ-1 и топ-2 для религии
	SELECT gr2, r1, r_c1, r2, r_c2 from (
	    SELECT guid gr1, religion r1, COUNT(religion) r_c1 FROM `user_groups`
	    GROUP BY guid, religion
	) i1, (
	    SELECT guid gr2, religion r2, COUNT(religion) r_c2 FROM `user_groups`
	    GROUP BY guid, religion
	) i2 WHERE gr1=gr2 HAVING r_c2 < r_c1
) t2
WHERE g0=g2 AND g0=gr2
ORDER BY c_n0 DESC