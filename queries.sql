drop table suppliersg;
drop table suppliersr;


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

/*For every supplier that supplies only green parts, print the name 
of the supplier and the total number of parts that he supplies. */
select suppliers.sname, count(catalog.pid)
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid
and
not exists(
select catalog.sid
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid and parts.color != 'Green')
group by suppliers.sname;

/* For every supplier that supplies green part and red part, print the 
name of the supplier and the price of the most expensive part that 
he supplies. pid (1 or 3 or 8) and 9 which means big red tools and perfunctory parts should return */
/*
select catalog.sid, catalog.cost
into suppliersg
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid and parts.color = 'Green';

select catalog.sid, catalog.cost
into suppliersr
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid and parts.color = 'Red';

select suppliers.sname, max(suppliersr.cost)
from suppliers, suppliersr, suppliersg, catalog
where suppliersr.sid = suppliersg.sid and suppliersr.sid = suppliers.sid
group by suppliers.sname;

*/
select sname, cost
from (
select E.sname, B.cost
from catalog A
cross join
catalog B
cross join
parts C
cross join
parts D
cross join
suppliers E
where(A.sid = B.sid and A.pid = C.pid and B.pid = D.pid and C.color = 'Green' and D.color = 'Red' and B.cost > A.cost and E.sid = A.sid)) L;
