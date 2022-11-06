/* Find the total number of parts supplied by each supplier */
SELECT Suppliers.sname, COUNT(Catalog.pid)
FROM Catalog, Suppliers, Parts
WHERE Catalog.sid = Suppliers.sid AND Catalog.pid = Parts.pid
GROUP BY Suppliers.sname;


/*Find  the  total  number  of  parts  supplied  by  each  supplier  who 
supplies at least 3 parts. */
SELECT Suppliers.sname, COUNT(Catalog.pid)
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid 
group by Suppliers.sname
having COUNT(catalog.pid) >= 3;

