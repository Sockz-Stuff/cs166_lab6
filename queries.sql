/* Find the total number of parts supplied by each supplier */

SELECT COUNT(Parts.pid)
FROM Parts, Suppliers, Catalog
WHERE Parts.pid = Catalog.pid AND Suppliers.sid = Catalog.sid;

