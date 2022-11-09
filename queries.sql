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


/*these are the ones that are the extra ones that are to be developed in the java file i made them here first to make sure it worked*/

select pname 
from parts, catalog, suppliers
where(catalog.sid = suppliers.sid and catalog.pid = parts.pid and catalog.cost < 4)
group by pname;

select address 
from parts, catalog, suppliers
where(catalog.sid = suppliers.sid and catalog.pid = parts.pid and pname = 'Acme Widget Washer')
group by address;

/*
select pname, sname
from parts, suppliers, 
(
select pid, sid
from catalog
where cost = (select max(cost) from catalog)
)D
where parts.pid = D.pid and suppliers.sid = D.sid;
*/


/* Problem 1 */

/* #6 */
select p.pid, s.sname
from parts p, suppliers s, catalog c
where p.pid = c.pid and s.sid = c.sid
and c.cost =
(
select max(R.cost)
from catalog R
where R.pid = p.pid
);

/* #7 */
select distinct c.sid
from catalog c
where not exists
(
select *
from parts p, suppliers s
where c.sid = s.sid and c.pid = p.pid and p.color != 'Red'
)
EXCEPT
select distinct c.sid
from catalog c
where not exists
(select *
from parts p, suppliers s
where c.sid = s.sid and c.pid = p.pid and p.color = 'Red'
)
; 

/* 8 */
/* Find the sids of suppliers who supply a red part and a green part. */

((select  c.sid
from parts p, catalog c
where c.pid = p.pid and p.color != 'Red'
)intersect
(select  c2.sid
from catalog c2, parts p2 
where c2.pid=p2.pid and p2.color!='Green'
))
intersect
(
select c3.sid
from parts p3, catalog c3
where c3.pid = p3.pid and (p3.color = 'Red' or p3.color = 'Green')
)
;

/* 9 */
/* Find the sids of suppliers who supply a red part or a green part */

select distinct c.sid
from parts p, catalog c
where c.pid = p.pid and (p.color = 'Red' or p.color = 'Green')
;

/* 10 */
/*  For every supplier that only supplies green parts, print the name of the supplier
and the total number of parts that she supplies */

select suppliers.sname, count(catalog.pid)
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid
and
not exists(
select catalog.sid
from catalog, suppliers, parts
where catalog.sid = suppliers.sid and catalog.pid = parts.pid and parts.color != 'Green')
group by suppliers.sname;


/* 11 */
/* For every supplier that supplies a green part and a red part, print the name and
price of the most expensive part that she supplies */

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
where(A.sid = B.sid and A.pid = C.pid and B.pid = D.pid and C.color = 'Green' and 
D.color = 'Red' and B.cost > A.cost and E.sid = A.sid)) L;


/* Problem 2 */

/* 3 */
/* Print the name of each employee whose salary exceeds the budget of all of the
departments that he or she works in. */

select e.eid
from emp e, works w, dept d
where e.eid = w.eid and w.did = d.did and e.salary > d.budget;


/* 6 */
/* If a manager manages more than one department, he or she controls the sum of all
the budgets for those departments. Find the managerids of managers who control
more than $5 million. */

select e.eid 
from emp e, dept d,
where  e.eid=d.managerid and SUM(d.budget)>5000000
;


/* Problem 3 */

/* a */
select e.ename
from (
employee e
cross join
manages m
cross join
employee f
)
where (e.ename = m.mname and e.ename != f.ename 
and e.city = f.city and e.street = f.street);

/* b */

select e.ename
from emplyee e,
(select w.ename w.cname, avg(w.salary)
from works w
group by w.cname) D,
works w,
where e.ename = D.ename and w.cname = D.cnamen and w.salary > D.salary
;

