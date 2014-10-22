# Среднестатистический пользователь
SELECT first_name, last_name, sex, smoking, alcohol, avg_groups FROM (
    SELECT first_name, COUNT(first_name) FROM `user` u1
	    GROUP BY first_name
	    ORDER BY COUNT(first_name) DESC
	    LIMIT 1
) t1, (
    SELECT last_name, COUNT(last_name) FROM `user` u2
	    GROUP BY last_name
	    ORDER BY COUNT(last_name) DESC
	    LIMIT 1
) t2, (
    SELECT sex, COUNT(sex) FROM `user` u3
	    GROUP BY sex
	    ORDER BY COUNT(sex) DESC
	    LIMIT 1
) t3, (
    SELECT smoking, COUNT(smoking) FROM `user` u4
	    GROUP BY smoking
	    ORDER BY COUNT(smoking) DESC
	    LIMIT 1
) t4, (
    SELECT alcohol, COUNT(alcohol) FROM `user` u5
	    GROUP BY alcohol
	    ORDER BY COUNT(alcohol) DESC
	    LIMIT 1
) t5, (
    SELECT AVG(t_guid) avg_groups FROM (
    	SELECT u6.uid, COUNT(s1.guid) t_guid from `user` u6
	    	JOIN user_subscriptions s1 ON (s1.uid = u6.uid)
	    	GROUP BY u6.uid
	    	ORDER BY COUNT(s1.guid) DESC
	) i1
) t6